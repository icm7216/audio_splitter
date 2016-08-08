# audio_splitter

アナログ音源のMP3化や、長尺のオーディオファイルの分割に便利なスクリプトです。

*   オーディオファイルを指定した時間でトラックごとに分割。
*   分割したオーディオデータにメタデータを付与してMP3形式で出力。


# メタデータの指定方法

ファイル分割とメタデータ用の設定ファイル`audio_splitter.yaml`を作成します。ファイルのフォーマットはYAMLです。

メタデータに指定可能な項目は「アーチスト名」と「アルバムタイトル」、「トラック名」です。

「出力ファイル名」にトラック名使用しますので、ファイル名で無効な文字をトラック名に使用することはできませんので注意してください。。


## `audio_splitter.yaml`の記入例

### target audio file

処理対象のオーディオファイル名に`Full_Album.wav`を指定

```
# target audio file
:file:    "Full_Album.wav"
```

### artist, album

アーチスト名`Artist Name`とアルバムタイトル`Album Name`を指定

```
# artist name
:artist:  "Artist Name"

# album title
:album:   "Album Name"
```

### track name and track time

トラック名`title`と分割時間`time`を指定します。下の例ではトラック名に`track title 1`,`track title 2`,`track title 3`,`track title 4`と分割点の時間を指定しています。ここでの分割時間は、ファイルの先頭から分割点までの経過時間を指定します。

トラック名と分割時間の値が配列の要素になっています。記述の際は行頭のインデントや`-`記号に注意してください。 また、インデントは半角スペースを使用します、タブ文字は使用できないので注意してください。

```
# track name and track time
# split the track of a file at a specified time.
# "time" is the elapsed time from "00:00:00"
:track:
  - :title: "track title 1"
    :time:  "00:09:16"

  - :title: "track title 2"
    :time:  "00:20:33"

  - :title: "track title 3"
    :time:  "00:31:40"

  - :title: "track title 4"
    :time:  "00:41:20"
```

行頭が`#`で始まる行はコメント行です。


YAMLの書き方がわからないときは [Rubyist Magazine - プログラマーのための YAML 入門 (初級編)](http://magazine.rubyist.net/?0009-YAML#l2) を一読してください。
