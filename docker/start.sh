ffmpeg \
-hide_banner \
-loglevel info \
-re \
-i "$url" \
-loop 1 -i assets/overlay.png \
-filter_complex "\
[0:v]scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2[video];\
[1:v]scale=1280:720[overlay];\
[video][overlay]overlay=0:0,\
drawtext=fontfile=fonts/Orbitron-Bold.ttf:text='🔴 LIVE':fontsize=28:fontcolor=red:x=40:y=40,\
drawtext=fontfile=fonts/Orbitron-Bold.ttf:text='Footage Courtesy: NASA & SpaceX':fontsize=20:fontcolor=white:x=(w-text_w)/2:y=h-40\
" \
-r 30 \
-c:v libx264 \
-preset ultrafast \
-tune zerolatency \
-pix_fmt yuv420p \
-b:v 3000k \
-maxrate 3000k \
-bufsize 6000k \
-g 60 \
-keyint_min 60 \
-c:a aac \
-b:a 128k \
-ar 44100 \
-ac 2 \
-shortest \
-f flv \
"rtmp://a.rtmp.youtube.com/live2/${YOUTUBE_STREAM_KEY}"
