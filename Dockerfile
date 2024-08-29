FROM almalinux:latest

# アプリケーションディレクトリを作成する
WORKDIR /app

# 必要なパッケージをインストール
RUN yum install -y git tar gzip xz python python-pip

# ffmpegのダウンロードとインストール
RUN curl -fSL https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-i686-static.tar.xz -o ffmpeg.tar.xz
RUN tar -xJf ffmpeg.tar.xz
RUN mv ffmpeg-*/ffmpeg /usr/local/bin/
RUN mv ffmpeg-*/ffprobe /usr/local/bin/
RUN rm -rf ffmpeg-*/
RUN rm ffmpeg.tar.xz

# pipのアップデート
RUN pip install --upgrade pip
# Pythonパッケージのインストール
COPY requirements.txt ./
RUN pip install -r requirements.txt
