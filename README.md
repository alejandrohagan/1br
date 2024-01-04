# Hi!

-  This is the repo inspired by [Gunnar Morlng's](https://www.morling.dev/blog/one-billion-row-challenge/) 1 billion row challenge to see which functions / libararies are quickest in summarizing the mean, min and max of a 1 billion rows of record
-  Actually, [Gunnar's](https://twitter.com/gunnarmorling/) efforts are more robust as its a challenge to the Java community to optimize their code to reduce the processing speed whereas I'm just taking available packages and comparing them
  
    -  I tried to download the orignal Java repo but since I know absolutely  nothing about Java this predictiblity failed
    -  So this isn't the same dataset as the original challenge but it is billion rows of record which I think is the important part of the challenge
-  Please feel free to fork or copy the repo and reproduce the findings
-  
-  A few notes:
    
    -  The underlying file is large (~20GB) so that isn't in  the report, however the `generate_data.R` script will produce this for you from your command line (see instructions)
    -  I ran the analysis in a Saturn Cloud cluster, my computer struggled with a bencmarking billion rows of data multiple times (you can specify how many rows of data you want generated if you want to run it locally)
    -  I'm fairly new to tidypolars and data.table so if you see any issues with the script that I wrote please tell me!
    -  The general format is that each functoin test is aggregate by their data workflow eg. sincee dplyr and collapse use regular data.frames they are kept together and since duckdb and arrow can leverage the same datasource, they can also be kept together

 # Instructions

 -  Using any flavor of a linux command line run `./generate_data.R` in your command line with the input of rows you want created eg:
 ```
$ ./generate_data.R 1e9
```
note: you may need to change the file permission `$ chmod +x generate_data.R`

-  This will create a new folder called "data" which will contain the measurement.txt file
-  From there, you can either run each test script individually (eg. dt.R) or you can run them all together via the 1br.R which will source all the scripts
-  The format of each test script is largely the same
  -  load libaries
  -  read data (usign data.table::fread)
  -  convert data appropriate format (if necessary)
  -  create functions that summarize mean, min, max by the respective libraries
  -  benchmark results 10 times
  -  save results in csv file

-  If you see any issues or have suggestions of improvements, please let me know!
