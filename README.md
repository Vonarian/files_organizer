## **Files Organizer**

A simple, lightweight, and fast file organizer, allowing Windows users to organize files in a
directory in their own category.

### **Usage**

Check [releases](https://github.com/Vonarian/files_organizer/releases) for already-built versions.

Run the program from a terminal or inside your Windows program by invoking console commands.

Run the following command to read how to use the app:

`.\FilesOrganizer.exe -h`

The `-h` command will output supported file extensions and how to use the app's primary function.

To organize files in a directory, for example, `C:\MyFolder`, invoke the following:

`.\FilesOrganizer.exe -d C:\MyFolder`

The program will organize all the files in the given directory. Make sure the directory is
accessible, files are not read-only.

If you're trying to organize files in a folder that needs elevated access, make sure you run your
terminal as administrator or the application will have permission issues, causing the code to throw.

Application will write the execution time in case of successful work.

### **Build The App**

The program is written in `dart` language and, therefore, the Dart SDK is mandatory to compile and
build the executable.

[Install the Dart SDK](https://dart.dev/get-dart), then, run the following commands inside the
project directory to compile the executable:

`dart pub get`

`dart compile exe .\bin\files_organizer.dart -o .\<Output name>.exe`

The output name can be anything.

#### **Supported Platforms**:

Currently, only Microsoft Windows is supported. This program is guaranteed to work on x64 Windows
10/11.

Note: Dart has a [Flutter framework](http://flutter.dev/) as well. You can build cross-platform
applications which run on many other platforms.

### **Planned Work**:

*    [ ]  Add the ability to add a list of default directories to the program to organize them at
     each launch
*    [ ]  Add a hotkey to organize a list of directories added by the user
*    [ ]  Add a run-at-startup feature after implementing the above features.

### **Contributions**:

Feel free to report application issues, request features, and discuss possible improvements to
the [Issues section](https://github.com/Vonarian/files_organizer/issues) of this GitHub repo.

Pull requests are welcome!