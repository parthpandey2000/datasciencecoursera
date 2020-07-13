#### **The script, 'run_analysis.R' initally prepares the data acquisition and then performs the tasks defined by the course project guidelines**  

* ##### Downloading and unzipping the folder
  + The required dataset is downloaded and unzipped in folder  named 'UCI HAR Dataset', if the dataset is not present.  

* ##### Reading the required text files and assigning the data to defined variables
  + `feature` <- `features.txt` Dimensions: [561*2]  
  Selected features are 'Gyroscope' and 'Accelerometer' => 'tAcc-XYZ' and 'tGyro-XYZ'.  
  + `subTest` <- `subject_test.txt` Dimensions: [2947*1]  
  9/30 Volunteer subject's Test data  
  + `subTrain` <- `subject_train.txt` Dimensions: [7352*1]  
  21/30 Volunteer subject's Train data  
  + `xTest` <- `test/X_test.txt` Dimensions: [2947*561]  
  Contains recorded features test data  
  + `yTest` <- `test/Y_test.txt` Dimensions: [2947*1]  
  Contains test data of activities’code labels  
  + `xTrain` <- `test/X_train.txt` Dimensions: [7352*561]  
  Contains recorded features train data  
  + `yTrain` <- `test/Y_train.txt` Dimensions: [7352*1]
  Contains train data of activities’code labels  
  + `activity` <- `activity_labels.txt` Dimensions: [6*2]  
  Contains list of activities and their code corresponding to the taken measurements

* ##### Merging the read datasets   
  + `sub` <- Dimensions: [10299*1]  
  Created by ***row-binding*** `subTrain` and `subtest`  
  + `xData` <- Dimensions: [10299*561]  
  Created by ***row-binding*** `xTrain` and `xTest`  
  + `yData` <- Dimensions: [10299*1]  
  Created by ***row-binding*** `yTrain` and `yTest`
  + `mergedData` <- Dimensions: [10299*563]  
  Created by ***column-binding*** `sub`, `yData` and `xData`
  
* ##### Extraction of only required data from above defined varibales containing data
  + `mergedData2` <- Dimensions: [10299*88]  
  Created by selecting only `subj` and `id` and subsetting `mergedData` to columns containing `mean` and `std`
  
* ##### Changing Activity names to predefined activity names  
  + Entire numbers in `id` column of the `mergedData2` replaced with corresponding activity taken from second column of the `activity` variable  
  
* ##### Labelling the dataset with proper user-friendly labels  
  + `id` column in `mergedData2` renamed into `Activity`  
  + All `gravity` in column's name is replaced by `Gravity`  
  + All `Acc` in column’s name replaced by `Accelerometer`  
  + All `Gyro` in column’s name replaced by `Gyroscope`     
  + All start with character `f` in column’s name replaced by `Frequency`     
  + All `BodyBody` in column’s name replaced by `Body`  
  + All `Mag` in column’s name replaced by `Magnitude`
  + All `-std()` in column's name is replaced by `STD`  
  + All start with character `t` in column’s name replaced by `Time`   
  
* ##### Creating independant tidy data from the previous data `mergedData2`  
  + `Ready_DataSet` <- Dimensions: [180*88]  
  By grouping the `mergedData2` into the `subject` and `activity` and then summarizing it by taking means over the defined groups, we get final data `Ready_DataSet`  