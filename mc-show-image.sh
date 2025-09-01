resolution=$(identify "$1" | grep -oE '[0-9]+x[0-9]+' | head -n 1)
IFS='x' read -r width height <<<"$resolution"
max=1000
if ((width > height)); then
  scale=$(echo "scale=4; $max / $width" | bc)
else
  scale=$(echo "scale=4; $max / $height" | bc)
fi
new_width=$(printf "%.0f" "$(echo "$width * $scale" | bc -l)")
new_height=$(printf "%.0f" "$(echo "$height * $scale" | bc -l)")
img2sixel -w $new_width -h $new_height "$1"
echo
echo "Press any key to return to MC..."
read -r -s -n 1 -t 5
