import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
class  EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product'; 
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageurlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id:null,
    title: '',
    price: 0,
    imageurl: '',
    description: '', 
    );
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }
  var _isInit = true;
  var _initValues = {
    'title':'',
    'description':'',
    'price':'',
    'imageurl':'',
  };
  var _isloading = false;
  @override
  void didChangeDependencies() {
    if (_isInit){
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId!=null){
      _editedProduct = Provider.of<Products>(context,listen: false).findById(productId);
      _initValues = {
        'title':_editedProduct.title,
        'desciption':_editedProduct.description,
        'price':_editedProduct.price.toString(),
        'imageurl':'',
      };
      _imageurlController.text = _editedProduct.imageurl;
      }
      }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  void dispose(){
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageurlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }
  Future<void> _saveform() async {
    final isValid = _form.currentState.validate();
    if (!isValid){
      return ;
    }
    _form.currentState.save();
    setState(() {
      _isloading = true;
    });  
    if (_editedProduct.id!=null){
      await Provider.of<Products>(context,listen: false,).updateProduct(_editedProduct.id,_editedProduct);
    } else{
      try{
        await Provider.of<Products>(context,listen: false,).addProduct(_editedProduct);
      } catch (error){
        await showDialog(context: context,
        builder:(ctx)=>
        AlertDialog(title: Text('An error occured'),
        content: Text('Something went wrong.'),
        actions: [
        FlatButton(onPressed: () {
          Navigator.of(ctx).pop();
        }, child: Text('Okay'))
      ],
      )
      );
      } 
      // finally {
      //   setState(() {
      //   _isloading = false;
      // });
      // Navigator.of(context).pop();
      // }
    }
    setState(() {
        _isloading = false;
      });
      Navigator.of(context).pop();
    }
  void _updateImageUrl (){
    if(!_imageUrlFocusNode.hasFocus){
      if (_imageurlController.text.isEmpty || 
      !_imageurlController.text.startsWith('http') &&
       !_imageurlController.text.startsWith('https')){
          return;
      setState(() {});
    }
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed:_saveform, )
        ],
        ),
        body: _isloading? 
        Center(child:CircularProgressIndicator(),
        )
        :Padding(
          padding: const EdgeInsets.all(16.0),
        child:Form(
          key: _form,
          child: ListView(children: [
            TextFormField(
              initialValue: _initValues['title'],
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator: (value) {
                if(value.isEmpty){
                  return 'Please provide a value';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(title: value,
                price: _editedProduct.price,
                imageurl: _editedProduct.imageurl,
                id: _editedProduct.id,
                isfavourite: _editedProduct.isfavourite,
                description: _editedProduct.description);
              },
            ),
            TextFormField(
              initialValue: _initValues['price'],
              decoration: InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              validator: (value){
                if (value.isEmpty){
                  return 'Please enter a price';
                }
                if(double.tryParse(value)==null){
                  return 'Please enter a valid number';
                }
                if(double.tryParse(value)<=0){
                  return 'Please enter a number greater than 0';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                title: _editedProduct.title,
                price: double.parse(value),
                imageurl: _editedProduct.imageurl,
                id: _editedProduct.id,
                isfavourite: _editedProduct.isfavourite,
                description: _editedProduct.description);
              },
            ),
            TextFormField(
              initialValue: _initValues['description'],
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              validator: (value) {
                if (value.isEmpty){
                  return 'Please enter a description';
                }
                if (value.length<10){
                  return 'Should not be less than 10 characters';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                title: _editedProduct.title,
                price: _editedProduct.price,
                imageurl: _editedProduct.imageurl,
                id: _editedProduct.id,
                isfavourite: _editedProduct.isfavourite,
                description: value);
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:[
              Container(
                width:100,
                height:100,
                margin:EdgeInsets.only(top:8,right:10,),
                decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black,
                ),
                ),
                child: _imageurlController.text.isEmpty ?
                Text('Enter a URL'):
                FittedBox(child: Image.network(
                _imageurlController.text,
                fit: BoxFit.cover,),),
              ),
              Expanded(
                child:TextFormField(
                decoration: InputDecoration(labelText:'Image URL'),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                controller: _imageurlController,
                focusNode: _imageUrlFocusNode,
                onFieldSubmitted: (_)=> {
                  _saveform(),
                },
                onSaved: (value) {
                _editedProduct = Product(
                title: _editedProduct.title,
                price: _editedProduct.price,
                imageurl: value,
                id: _editedProduct.id,
                isfavourite: _editedProduct.isfavourite,
                description: _editedProduct.description);
              },
              ),
              ),
            ],)
          ],
          ),
          ),),
        );
  }
  }