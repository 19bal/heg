ACG-VID-EMG eş zamanlama çalışmasının video ayağı-renkli marker kullanımı

## null

Bu çalışmada kullanılan databaseden [y_ns01.avi](https://github.com/downloads/19bal/heg/renkli_marker_alpha.csv) den bir kare,

![db](https://github.com/19bal/heg/raw/master/elhizi/img/db_marker_renkli.jpg)

bu karenin önişlenmesinin ardından el bölgesinin çıkarılmasıyla elde edilen siyah-beyaz görüntü,

![bw](https://github.com/19bal/heg/raw/master/elhizi/img/db_marker_renkli_bw.jpg)

siyah-beyaz görüntü üzerinde markerları ele veren özelliklerin görüntü işlemeyle sınanmasıyla filtrelenerek
elde edilen noktalara ait siyah-beyaz görüntü,

![points](https://github.com/19bal/heg/raw/master/elhizi/img/db_marker_renkli_points.jpg)

bu noktaları ve maske altındaki görüntünün renk değerleri de dikkate alınarak hangi parmak olduğu
bilgisiyle birlikte marker koordinatları (resmimiz `480x640` boyutlarında),

		hand =

			index: [247.3105 212.5343]
			 palm: [428.5948 281.7756]
			thumb: [267.9629 338.9237]

tüm video ardışıllığı için bulunan markerlar,

![markers](https://github.com/19bal/heg/raw/master/elhizi/img/db_marker_renkli_markers.gif)

markerlar bulunduktan sonrası açının hesabı. bu test ardışıllığı için elde ettiğimiz açının değişimine dair ilkin sonuçlar,

![alpha](https://github.com/19bal/heg/raw/master/elhizi/img/renkli_marker_alpha.jpg)

CSV olarak ise download kısmına da konuldu: [csv olarak sonuçlar](
https://github.com/downloads/19bal/heg/renkli_marker_alpha.csv)
