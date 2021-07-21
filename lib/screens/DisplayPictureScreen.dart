import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);


  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;

  String text='';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _openImage());
  }

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context,listen: false);

    return WillPopScope(
      onWillPop: () async => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraIslemleri()), ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
          ),
        ),
      ),
    );
  }

  Future imageAdder(BuildContext context) async {
    _file = File(widget.imagePath);
    _sample = await ImageCrop.sampleImage(
      file: _file,
      preferredSize: context.size.longestSide.ceil(),
    );
  }

  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(_sample, key: cropKey),
        ),
        Container(
          //color: Colors.green,
          //height: 200,
          padding: const EdgeInsets.only(top: 20),
          alignment: AlignmentDirectional.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 50,
                child: TextButton(
                  child: Text(
                    'Crop Image',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () => _cropImage(),
                ),
              ),
              // _buildOpenImage(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    print("open image methodu çalıştı");
    return TextButton(
      child: Text(
        'Open Image',
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
      ),
      onPressed: () => _openImage(),
    );
  }

  Future<void> _openImage() async {
    //final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    print("buraya gelindi");
    final file = File(widget.imagePath);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size.longestSide.ceil(),
    );

    _sample?.delete();
    _file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
  }

  Future<File> _cropImage() async {
    print("crop image methodu çalıştı");
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      print("herhangi bir fotoğraf gelmedi");
      return null;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _file,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();
    /// final text = await FirebaseMLApi.recogniseText(file);

    setState(()  {
      _lastCropped?.delete();
      _lastCropped = file;
      _sample = file;
      print("--------------------------------------------"+ text);
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) => NotePage(text)));

    // geriye bir imagepath dönüyor bu pathi bir başka class a göndererek kesilmiş görselden yazı okuma sağlanacak.
    return file;
  }
}