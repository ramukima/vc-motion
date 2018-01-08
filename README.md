# vc-motion
Motion Activated Video 

git clone
cd vc-motion

docker build -t vc-motion .

docker run -e PUID="0" -e PGID="0" --rm --name=vc-motion -v ~/user/appdata/motioneye/config:/config -v ~/user/appdata/motioneye/media:/home/nobody/motioneye/media --device /dev/video0 -p 8081:8081 vc-motion

