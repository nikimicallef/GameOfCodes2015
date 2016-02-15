@echo off
echo "This is PaulOS' submission for Game of Codes 2015."
echo "Please read the 'Read this file first.txt' and then the 'install.txt' text files before executing.
echo "Please make sure you add the input cjp file and composition text in the directry. It will still work if you give the absolute path, but the former is prefered."
echo "Also, please make sure you installed the runtime enviroment as mentioned in the read me!"
echo "Please note that the MatLAB enviroment takes some time to start up, which implements our execution time. We included the time takes for the method alone to execute, along with a line which tells you when the method itself starts to execute.Nonetheless, we 'hacked' this as explained in the 'Read this file first.txt'. We apreciate if you follow these conventions."
echo "Enter the cjp file of the image to exec. i.e. pikachu.cjp"
set /p para1=
echo "Enter composition text file. i.e. composition_text.txt"
set /p para2=
echo "Enter no. of boxes. i.e. 30"
set /p para3=
echo "Enter the output image name. i.e. output.clg"
set /p para4=
Main.exe %para1% %para2% %para3% %para4%