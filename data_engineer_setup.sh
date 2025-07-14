#!/bin/bash

clear
echo "=========================================="
echo "  Data Engineering Environment Setup Tool "
echo "=========================================="
echo

# Choose installation mode

echo "Select installation mode:"
echo "1) Auto - Install all tools at once"
echo "2) Interactive - Choose which tools to install"
echo

read -p "Enter 1 or 2: " mode

# List of tools with their installation commands
declare -A tools=(
  [Python]="sudo apt install -y python3"
  [pip]="sudo apt install -y python3-pip"
  [Git]="sudo apt install -y git"
  [Docker]="sudo apt install -y docker.io"
  [PostgreSQL]="sudo apt install -y postgresql postgresql-contrib"
  [Java]="sudo apt install -y openjdk-17-jdk"
  [Jupyter]="pip3 install notebook"
  [AWS-CLI]="pip3 install awscli"
  [Airflow]="pip3 install apache-airflow"
)

### Update System Package
#echo "Updating system packages..."
#sudo apt update -y

# Log file and logging function
LOG_FILE="install_log.txt"

log_result(){
	if [ $? -eq 0 ]; then
	   echo "[$(date + %F %T)] $1 installed successfully" >> "$LOG_FILE"
	else
	   echo "[$(date + %F %T)] $1 installed failed" >> "$LOG_FILE"
	fi
}

## Function to install Apache Spark
install_spark() {
   echo "Installing Apache Spark..."
   wget https://downloads.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz
   tar -xzf spark-3.5.0-bin-hadoop3.tzg
   sudo mv spark-3.5.0-bin-hadoop /opt/spark
   echo "export SPARK_HOME=/opt/spark" >> ~/.bashrc
   echo "export PATH=\$PATH:$SAPRK_HOME/bin:\$SPARK_HOME/sbin" >> ~/.bashrc
   source ~/.bashrc
   echo "Spark intalled successfully"
}

### Auto mode: install Every This Mode: 1
if [[ "$mode" == "1" ]]; then
	echo "Installing all tools automatically..."
	for name in "${!tools[@]}"; do
		echo "Installing $name..."
		eval "${tools[$name]}"
		log_result"$name"
	 done
	 install_spark
	 echo "All tools have been installed successfully."
### Interactive mode: choose what to install 
elif [[ "$mode" == "2" ]]; then
	echo "Interactive mode - select tools to install:"
	for name in "${!tools[@]}"; do
		read -p "Do you want to install $name ? (y/n): " ans
		if [[ "$ans" == "y" || "$ans" == "Y" ]]; then
			echo "Installing $name ..."
		       eval "${tools[$name]}"
		       log_result "$name"
	       else
			echo "Skipping $name"
	 	fi
		echo 
		done

		read -p "Do you wnat to Install Apache Spark ? (y/n): " spark_ans
		if [[ "$spark_ans" == "y" || "$spark_ans" == "Y" ]]; then
			install_spark
		else
			echo "Skipping Spark"
		fi
   # Invalid INPUT
   else
	echo "Invalid input. Please return the Script and select a valid option."
        exit 1
   fi


 echo "=========================================="
 echo " Setup Completed"
 echo "=========================================="
 echo
 echo " Thank you for using the Data Engineering Environment Setup Tool!"
 echo " If you have any questions or suggestions, feel free to contact me:"
 echo "abdallahfathy683@gmail.com"
 echo
 echo "Wishing you a smooth and productive data engineering journey!"

 
