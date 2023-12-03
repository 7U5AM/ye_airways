import 'dart:io';

import 'package:ye_airways/model/des_model.dart';
import 'package:ye_airways/provider/destination_provider.dart';
import 'package:ye_airways/shared/components/components.dart';
import 'package:ye_airways/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddDestinationPage extends StatefulWidget {
  static const String id = 'AddDestinationPage';

  const AddDestinationPage({super.key});

  @override
  State<AddDestinationPage> createState() => _AddDestinationPageState();
}

class _AddDestinationPageState extends State<AddDestinationPage> {
  late TextEditingController toController;
  late TextEditingController fromController;
  late TextEditingController citynameController;
  late TextEditingController descriptionController;
  late TextEditingController ratingController;
// Flight Tools
  late TextEditingController flightNumberController;
  late TextEditingController ticketPriceController;
  TextEditingController? _dateController;
  TextEditingController? _timeController;
  late TextEditingController durationController;

  final _formKey = GlobalKey<FormState>();
  File? priam_imageFile;

  final _picker = ImagePicker();
  String? date;
  String? time;
  var destinationType = ['Popular', 'Local', 'New'];
  String? destTypeSelected;
  List<File> imageFileList = [];
  bool isLoading = false;
  @override
  void initState() {
    fromController = TextEditingController(text: "");
    toController = TextEditingController(text: "");
    descriptionController = TextEditingController(text: "");
    citynameController = TextEditingController(text: "");
    ratingController = TextEditingController(text: "4");
    flightNumberController = TextEditingController(text: "");
    ticketPriceController = TextEditingController(text: "300");
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    durationController = TextEditingController(text: "");

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _dateController!.dispose();
    _timeController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void selectImages() async {
      final selectedImages = await _picker.pickMultiImage(imageQuality: 50);
      if (selectedImages.isNotEmpty) {
        imageFileList = [];
        for (var image in selectedImages) {
          imageFileList.add(File(image.path));
        }
      }
      print("Image List Length:${imageFileList.length}");
      setState(() {});
    }

    Future<void> _pickImageFromGallery() async {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        // imageQuality: 100,
        // maxHeight: 400,
        // maxWidth: 400,
      );
      if (pickedFile != null) {
        setState(() {
          priam_imageFile = File(pickedFile.path);
        });
      }
    }

    Future<void> _pickImageFromCamera() async {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 25,
        maxHeight: 200,
        maxWidth: 200,
      );
      if (pickedFile != null) {
        setState(() {
          priam_imageFile = File(pickedFile.path);
        });
      }
    }

    DestinationProvider destinationProvider =
        Provider.of<DestinationProvider>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //=================== Add Destination Image ===================
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ButtonBar(
                      children: [
                        Text(
                          'Add New Destination',
                          style: GoogleFonts.robotoCondensed(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        IconButton(
                          color: kPrimaryColor,
                          icon: const Icon(Icons.photo_camera),
                          onPressed: () async => _pickImageFromCamera(),
                          tooltip: 'Shoot picture',
                        ),
                        IconButton(
                          color: kPrimaryColor,
                          icon: const Icon(Icons.photo),
                          onPressed: () async {
                            _pickImageFromGallery();
                          },
                          tooltip: 'Pick from gallery',
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          _pickImageFromGallery();
                        },
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: (priam_imageFile != null)
                              ? Image.file(priam_imageFile!)
                              : const Placeholder(
                                  fallbackHeight: 300,
                                  fallbackWidth: 300,
                                ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),

                // insert others Destination Images
                IconButton(
                  color: kPrimaryColor,
                  icon: const Icon(Icons.photo),
                  onPressed: () async {
                    selectImages();
                  },
                  tooltip: 'Pick from gallery',
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (final image in imageFileList)
                      SizedBox(
                        height: 100,
                        width: 100,
                        // ignore: unnecessary_null_comparison
                        child: (image != null)
                            ? Image.file(image)

                            // Image.file(_1st_des_imageFile!)
                            : InkWell(
                                onTap: () async {
                                  _pickImageFromGallery();
                                },
                                child: const Placeholder(
                                  fallbackHeight: 100,
                                  fallbackWidth: 100,
                                ),
                              ),
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                //=================== From ===================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          15,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: fromController,
                        validator: ((value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          } else {
                            return "This field is Required";
                          }
                        }),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "From",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                //=================== Destination Name ===================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          15,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: toController,
                        validator: ((value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          } else {
                            return "Destination Name is Required";
                          }
                        }),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Destination Name",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                //=================== City ===================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          15,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                          controller: citynameController,
                          validator: ((value) {
                            if (value != null && value.isNotEmpty) {
                              return null;
                            } else {
                              return "Destination City is Required";
                            }
                          }),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Destination City",
                            // helperText: "required",
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                //=================== Description ===================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          15,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                          controller: descriptionController,
                          validator: ((value) {
                            if (value != null && value.isNotEmpty) {
                              return null;
                            } else {
                              return "description is Required";
                            }
                          }),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "write description",
                            // helperText: "required",
                          )),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                //=================== Destination Type ===================

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          15,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButton<String>(
                        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                        underline: const SizedBox(),
                        dropdownColor: kWhiteColor,
                        hint: const SizedBox(
                          width: 260,
                          child: Text(
                            'Destination Type       ',
                            style: TextStyle(
                              color: kInactiveTextColor,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        items: destinationType.map((String dropDownItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownItem,
                            child: Text(
                              dropDownItem,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: kPrimaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            destTypeSelected = newValue;
                          });
                        },
                        value: destTypeSelected,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),
                //=================== Rating ===================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          15,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        validator: ((value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          } else {
                            return "your rating is Required";
                          }
                        }),
                        // keyboardType: TextInputType.number,
                        controller: ratingController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "your rating",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // ================================ Flight Information ================================

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          15,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: flightNumberController,
                        validator: ((value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          } else {
                            return "Flight Number is Required";
                          }
                        }),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Flight Number",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                //=================== Flight Date ===================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          15,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: defaultFormField(
                        // type: TextInputType.datetime,
                        suffix: Icons.date_range,
                        controller: _dateController!,
                        label: 'DATE',
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                          ).then((date) {
                            this.date = DateFormat('yyyy MMM d').format(date!);
                            setState(() {
                              _dateController!.text = this.date!;
                            });
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                //=================== Flight Time ===================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          15,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AbsorbPointer(
                        absorbing: false,
                        ignoringSemantics: false,
                        child: defaultFormField(
                          suffix: Icons.access_time_outlined,
                          controller: _timeController!,
                          label: 'Flight Time',
                          type: TextInputType.datetime,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((time) {
                              this.time = time!.format(context);

                              setState(() {
                                _timeController!.text = this.time!;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // Description
                //=================== Flight Duration ===================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          15,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                          controller: durationController,
                          validator: ((value) {
                            if (value != null && value.isNotEmpty) {
                              return null;
                            } else {
                              return "Flight Duration is Required";
                            }
                          }),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Flight Duration",
                            // helperText: "required",
                          )),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),
                //=================== Price ===================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          15,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        validator: ((value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          } else {
                            return "Price is Required";
                          }
                        }),
                        controller: ticketPriceController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ticket price",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                //=================== Button Add Destination ===================
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomButton(
                          title: "Add",
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                priam_imageFile != null) {
                              setState(() {
                                isLoading = true;
                              });
                              await destinationProvider
                                  .addDestination(HN_DestinatioModel(
                                // urldesImages: imageFileList,
                                from: fromController.text,
                                desImage: priam_imageFile,
                                desOtherImages: imageFileList,
                                placename: toController.text,
                                to: citynameController.text,
                                description: descriptionController.text,
                                rating: ratingController.text != ""
                                    ? double.parse(ratingController.text)
                                    : 0,
                                flightNumber:
                                    "IY${flightNumberController.text}",
                                date: _dateController!.text,
                                time: _timeController!.text,
                                ticketPrice: ticketPriceController.text != ""
                                    ? double.parse(ticketPriceController.text)
                                    : 0,
                                duration: durationController.text,
                                desType: destTypeSelected,
                                seats: [],
                              ));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Added Successfully")));
                              Navigator.pop(context);
                            } else {
                              isLoading = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Error")));
                            }
                          },
                        ),
                      ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
