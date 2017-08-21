README
Coursera 'Cleaning and Getting Data', Assignment for Week 4


=====================================
Overview:

The repository contains the R-Script "run_analysis.R".
This script loads and merges data from the UCI HAR Dataset. 
It filters only for mean and std columns, and makes the table more descripive.
Lastly, it creates a summarised output called "tidy_data".

In addition, the repository also contains a codebook, based on the initial explanations provided. 

=====================================
Reading the files: 

The scripts loads six different txt-files.
It assumes that they are stored unzipped in the working directory. 
It also assumes that the highest folder is called 'UCI HAR Dataset'.
The structure of the underlying folders shoud be unchanged. 


=====================================
Filtering and cleaning: 

The script filters for all variable names that contain mean and std values. 
It uses the original variable naming with slight adjustments for readability. 

=====================================
Tidy data: 

The script finally summarises the data by grouping it by subject ID and activity, 
calculating the averages for these observations. 

The final output has 180 rows. 
