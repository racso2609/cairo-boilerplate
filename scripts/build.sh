FOLDER_OR_FILE_PATH=$1
function is_folder_or_file(){
  if [[ -f $1 ]];then
    echo "file"
  fi

  if [[ -d $1 ]]; then
    echo "dir"
  fi
}

function get_filename(){
  filename="${1%%.*}"

  echo $filename
}

function get_extension(){
  extension="${1#*.}"

  echo $extension
}
function compile_file(){
  cairo-compile $1 --output $2

}
function compile_folder(){
  FOLDER_CHILDS=$(ls $1)
  for i in $FOLDER_CHILDS;do
    IS_FILE_OR_FOLDER=$(is_folder_or_file "$1/$i")
    if [[ $IS_FILE_OR_FOLDER == 'file' ]];then
      EXTENSION=$(get_extension $i)
      FILENAME=$(get_filename $i)

      if [[ $EXTENSION == "cairo" ]];then
        compile_file "$1/$i" "compiled/$FILENAME.json" 
      fi
    else
      echo "$1/$i"
      compile_folder "$1/$i"
    fi
  done
}

file_or_folder_result="$(is_folder_or_file $FOLDER_OR_FILE_PATH)"

if [[ $file_or_folder_result == 'file' ]]; then
  FILE=${FOLDER_OR_FILE_PATH##*/}

  FILENAME=$(get_filename $FILE)
  EXTENSION=$(get_extension $FILE)


  if [[ $EXTENSION == 'cairo' ]];then
  compile_file $FOLDER_OR_FILE_PATH "compiled/$FILENAME.json"
  fi
else
  compile_folder $FOLDER_OR_FILE_PATH
fi

