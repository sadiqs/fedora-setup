declare -a fonts=(
  "FiraCode"
  "CascadiaCode"
  "InconsolataGo"
  "Overpass"
)

function dwUrl {
  echo "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$1.zip"
}

tempDir="fondue"

# rm -rf $tempDir
# mkdir -p $tempDir
cd $tempDir

function processFont {
  echo "Processing font: $1"
  url=$(dwUrl $1)
  fname="${1}.zip"
  [ -f "$fname" ] || curl -fLo $fname $url
  unzip -u $fname
}

function primaryname {
  echo "Received: $# ${@}"
  filename=$(basename -- "$1")
  extension="${filename##*.}"
  filename="${filename%.*}"
  echo $filename
}

echo ${fonts[@]}

function cleanFiles {
  rm -f *Windows*
  rm -f *Mono*

  mapfile -t names < <(ls -1 | tr '\n' '\0' | xargs -0 -n 1 basename)

  # names=$(ls -1 | tr '\n' '\0' | xargs -0 -n 1 basename)

  primaryname "${names[@]}"
#  | xargs echo


}

processFont "${fonts[1]}"
cleanFiles

## now loop through the above array
# for i in "${fonts[@]}"; do
  
# done
