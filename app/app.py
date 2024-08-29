from datetime import timedelta
import ffmpeg
import whisper
model = whisper.load_model("large")
filename = input("文字起こしするデータフォルダのファイル名（拡張子も含む）を入力してください: ")
file_path = f"data/{filename}"
result = model.transcribe(file_path, fp16=False,language="ja", verbose=True) #task="translate"
print(result["text"])
with open(f"srt_data/{filename}.srt", 'w', encoding='UTF-8') as file:
    for segment in result['segments']:
        start = timedelta(seconds=segment['start'])
        end = timedelta(seconds=segment['end'])
        text = segment['text']
        file.write(f"[{str(start)} --> {str(end)}] {text}\n")
print(f"入力結果がsrt_data/{filename}.srtファイルに保存されました。")