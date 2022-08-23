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
function execute_file(){
  cairo-run --program=$1 --print_output --print_info --relocate_prints --layout=small 
}

file_or_folder_result="$(is_folder_or_file $FOLDER_OR_FILE_PATH)"

if [[ $file_or_folder_result == 'file' ]]; then
  FILENAME=$(get_filename $FOLDER_OR_FILE_PATH)
  EXTENSION=$(get_extension $FOLDER_OR_FILE_PATH)
  if [[ $EXTENSION == 'json' ]];then
  execute_file $FOLDER_OR_FILE_PATH "$FILENAME.json"
  fi
fi
