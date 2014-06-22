progress = TRUE
#Verify Data Exists
if(file.exists("data")) {
  if(!file.exists("data/activity_labels.txt")) {
    print("Error: File data/activity_labels.txt not found")
    progress = FALSE
  }
  if(file.exists("data/test")) {
    if(!file.exists("data/test/subject_test.txt")) {
      print("Error: File data/test/subject_test.txt not found")
      progress = FALSE
    }
    if(!file.exists("data/test/y_test.txt")) {
      print("Error: File data/test/y_test.txt not found")
      progress = FALSE
    }
    if(file.exists("data/test/Inertial Signals")) {
      if(!file.exists("data/test/Inertial Signals/total_acc_x_test.txt")) {
        print("Error: File data/test/Inertial Signals/total_acc_x_test.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/test/Inertial Signals/total_acc_y_test.txt")) {
        print("Error: File data/test/Inertial Signals/total_acc_x_test.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/test/Inertial Signals/total_acc_z_test.txt")) {
        print("Error: File data/test/Inertial Signals/total_acc_z_test.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/test/Inertial Signals/body_acc_x_test.txt")) {
        print("Error: File data/test/Inertial Signals/body_acc_x_test.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/test/Inertial Signals/body_acc_y_test.txt")) {
        print("Error: File data/test/Inertial Signals/body_acc_y_test.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/test/Inertial Signals/body_acc_z_test.txt")) {
        print("Error: File data/test/Inertial Signals/body_acc_z_test.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/test/Inertial Signals/body_gyro_x_test.txt")) {
        print("Error: File data/test/Inertial Signals/body_gyro_x_test.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/test/Inertial Signals/body_gyro_y_test.txt")) {
        print("Error: File data/test/Inertial Signals/body_gyro_y_test.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/test/Inertial Signals/body_gyro_z_test.txt")) {
        print("Error: File data/test/Inertial Signals/body_gyro_z_test.txt not found")
        progress = FALSE
      }
    } else {
      print("Error: Directory data/test/Inertial Signals not found")
      progress = FALSE  
    }
  } else {
    print("Error: Directory data/test not found")
    progress = FALSE
  }
  if(file.exists("data/train")) {
    if(!file.exists("data/train/subject_train.txt")) {
      print("Error: File data/train/subject_train.txt not found")
      progress = FALSE
    }
    if(!file.exists("data/train/y_train.txt")) {
      print("Error: File data/train/y_train.txt not found")
      progress = FALSE
    }
    if(file.exists("data/train/Inertial Signals")) {
      if(!file.exists("data/train/Inertial Signals/total_acc_x_train.txt")) {
        print("Error: File train/Inertial Signals/total_acc_x_train.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/train/Inertial Signals/total_acc_y_train.txt")) {
        print("Error: File data/train/Inertial Signals/total_acc_x_train.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/train/Inertial Signals/total_acc_z_train.txt")) {
        print("Error: File data/train/Inertial Signals/total_acc_z_train.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/train/Inertial Signals/body_acc_x_train.txt")) {
        print("Error: File data/train/Inertial Signals/body_acc_x_train.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/train/Inertial Signals/body_acc_y_train.txt")) {
        print("Error: File data/train/Inertial Signals/body_acc_y_train.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/train/Inertial Signals/body_acc_z_train.txt")) {
        print("Error: File data/train/Inertial Signals/body_acc_z_train.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/train/Inertial Signals/body_gyro_x_train.txt")) {
        print("Error: File data/train/Inertial Signals/body_gyro_x_train.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/train/Inertial Signals/body_gyro_y_train.txt")) {
        print("Error: File data/train/Inertial Signals/body_gyro_y_train.txt not found")
        progress = FALSE
      }
      if(!file.exists("data/train/Inertial Signals/body_gyro_z_train.txt")) {
        print("Error: File data/train/Inertial Signals/body_gyro_z_train.txt not found")
        progress = FALSE
      }
    } else {
      print("Error: Directory data/train/Inertial Signals not found")
      progress = FALSE  
    }  
  } else {
    print("Error: Directory data/train not found")
    progress = FALSE
  }
} else {
  print("Error: Directory data not found")
  progress = FALSE
}
#Start Analysis
if(progress) {
  rm(progress)
  #Mount Active Table
  train <- read.table("data/train/subject_train.txt")
  test <- read.table("data/test/subject_test.txt")
  total_subject <- rbind(train,test)
  active <- read.table("data/activity_labels.txt")
  names(active) <- c("id_active","active")
  train <- read.table("data/train/y_train.txt")
  test <- read.table("data/test/y_test.txt")
  total <- rbind(train,test)
  total_subject <- cbind(total_subject,total)
  names(total_subject) <- c("id","id_active")
  merge_data <- merge(total_subject,active,by.x="id_active",by.y="id_active",all=TRUE)
  rm(active)
  total_subject$id_active <-merge_data$active
  rm(merge_data)
  names(total_subject) <- c("id","active")
  #Mount Total Accelerometer X Table
  train <- read.table("data/train/Inertial Signals/total_acc_x_train.txt")
  test <- read.table("data/test/Inertial Signals/total_acc_x_test.txt")
  total <- rbind(train,test)
  total <- data.matrix(total, rownames.force = NA)
  total_accelerometer_x <- cbind(total_subject[,1:2],total)
  total_accelerometer_x <- total_accelerometer_x[order(total_accelerometer_x$id),]
  write.table(total_accelerometer_x,"total_acc_x.txt")
  for(c in nrow(total_subject)) {
    total_subject$total_accelerometer_x_mean <-mean(total[c,])
    total_subject$total_accelerometer_x_sd <-sd(total[c,])
  }
  #Mount Total Accelerometer Y Table
  train <- read.table("data/train/Inertial Signals/total_acc_y_train.txt")
  test <- read.table("data/test/Inertial Signals/total_acc_y_test.txt")
  total <- rbind(train,test)
  total <- data.matrix(total, rownames.force = NA)
  total_accelerometer_y <- cbind(total_subject[,1:2],total)
  total_accelerometer_y <- total_accelerometer_y[order(total_accelerometer_y$id),]
  write.table(total_accelerometer_y,"total_acc_y.txt")
  for(c in nrow(total_subject)) {
    total_subject$total_accelerometer_y_mean <-mean(total[c,])
    total_subject$total_accelerometer_y_sd <-sd(total[c,])
  }
  #Mount Total Accelerometer Z Table
  train <- read.table("data/train/Inertial Signals/total_acc_z_train.txt")
  test <- read.table("data/test/Inertial Signals/total_acc_z_test.txt")
  total <- rbind(train,test)
  total <- data.matrix(total, rownames.force = NA)
  total_accelerometer_z <- cbind(total_subject[,1:2],total)
  total_accelerometer_z <- total_accelerometer_z[order(total_accelerometer_z$id),]
  write.table(total_accelerometer_z,"total_acc_z.txt")
  rm(total_accelerometer_z)
  for(c in nrow(total_subject)) {
    total_subject$total_accelerometer_z_mean <-mean(total[c,])
    total_subject$total_accelerometer_z_sd <-sd(total[c,])
  }
  #Mount Body Accelerometer X Table
  train <- read.table("data/train/Inertial Signals/body_acc_x_train.txt")
  test <- read.table("data/test/Inertial Signals/body_acc_x_test.txt")
  total <- rbind(train,test)
  total <- data.matrix(total, rownames.force = NA)
  body_accelerometer_x <- cbind(total_subject[,1:2],total)
  body_accelerometer_x <- body_accelerometer_x[order(body_accelerometer_x$id),]
  write.table(body_accelerometer_x,"body_accelerometer_x.txt")
  for(c in nrow(total_subject)) {
    total_subject$body_accelerometer_x_mean <-mean(total[c,])
    total_subject$body_accelerometer_x_sd <-sd(total[c,])
  }
  #Mount Body Accelerometer Y Table
  train <- read.table("data/train/Inertial Signals/body_acc_y_train.txt")
  test <- read.table("data/test/Inertial Signals/body_acc_y_test.txt")
  total <- rbind(train,test)
  total <- data.matrix(total, rownames.force = NA)
  body_accelerometer_y <- cbind(total_subject[,1:2],total)
  body_accelerometer_y <- body_accelerometer_y[order(body_accelerometer_y$id),]
  write.table(body_accelerometer_y,"body_accelerometer_y.txt")
  for(c in nrow(total_subject)) {
    total_subject$body_accelerometer_y_mean <-mean(total[c,])
    total_subject$body_accelerometer_y_sd <-sd(total[c,])
  }
  #Mount Body Accelerometer Z Table
  train <- read.table("data/train/Inertial Signals/body_acc_z_train.txt")
  test <- read.table("data/test/Inertial Signals/body_acc_z_test.txt")
  total <- rbind(train,test)
  total <- data.matrix(total, rownames.force = NA)
  body_accelerometer_z <- cbind(total_subject[,1:2],total)
  body_accelerometer_z <- body_accelerometer_z[order(body_accelerometer_z$id),]
  write.table(body_accelerometer_z,"body_accelerometer_z.txt")
  for(c in nrow(total_subject)) {
    total_subject$body_accelerometer_z_mean <-mean(total[c,])
    total_subject$body_accelerometer_z_sd <-sd(total[c,])
  }
  #Mount Body Gyroscope X Table
  train <- read.table("data/train/Inertial Signals/body_gyro_x_train.txt")
  test <- read.table("data/test/Inertial Signals/body_gyro_x_test.txt")
  total <- rbind(train,test)
  total <- data.matrix(total, rownames.force = NA)
  body_gyroscope_x <- cbind(total_subject[,1:2],total)
  body_gyroscope_x <- body_gyroscope_x[order(body_gyroscope_x$id),]
  write.table(body_gyroscope_x,"body_gyroscope_x.txt")
  for(c in nrow(total_subject)) {
    total_subject$body_gyroscope_x_mean <-mean(total[c,])
    total_subject$body_gyroscope_x_sd <-sd(total[c,])
  }
  #Mount Body Gyroscope Y Table
  train <- read.table("data/train/Inertial Signals/body_gyro_y_train.txt")
  test <- read.table("data/test/Inertial Signals/body_gyro_y_test.txt")
  total <- rbind(train,test)
  total <- data.matrix(total, rownames.force = NA)
  body_gyroscope_y <- cbind(total_subject[,1:2],total)
  body_gyroscope_y <- body_gyroscope_y[order(body_gyroscope_y$id),]
  write.table(body_gyroscope_y,"body_gyroscope_y.txt")
  for(c in nrow(total_subject)) {
    total_subject$body_gyroscope_y_mean <-mean(total[c,])
    total_subject$body_gyroscope_y_sd <-sd(total[c,])
  }
  #Mount Body Gyroscope Z Table
  train <- read.table("data/train/Inertial Signals/body_gyro_z_train.txt")
  test <- read.table("data/test/Inertial Signals/body_gyro_z_test.txt")
  total <- rbind(train,test)
  total <- data.matrix(total, rownames.force = NA)
  body_gyroscope_z <- cbind(total_subject[,1:2],total)
  body_gyroscope_z <- body_gyroscope_z[order(body_gyroscope_z$id),]
  write.table(body_gyroscope_z,"body_gyroscope_z.txt")
  for(c in nrow(total_subject)) {
    total_subject$body_gyroscope_z_mean <-mean(total[c,])
    total_subject$body_gyroscope_z_sd <-sd(total[c,])
  }
  #Order Total Subject By Id
  total_subject <- total_subject[order(total_subject$id),]
  #Mount Total Active And Order By Active
  total_active <- data.frame(levels(total_subject$active))
  for(c in 3:20)
  {
    total_active[[c - 1]] <- (tapply(total_subject[,c],total_subject$active,mean))
  }
  names(total_active) <- names(total_subject[,c(1,3:20)]);
  #Garbage
  rm(c)
  rm(train)
  rm(test)
  rm(total)
}
