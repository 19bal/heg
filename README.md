# Hem EMG hem de Görüntüden Elin Açma Kapama Hızının Çıkarılması

Seminer çalışması yol haritası burada

- DIPimage'in kurulması gerekir.[indir](http://www.diplib.org/download)
###DIPimage KURULUM
-1.İndirilen `dipimage_2.4.1_win32.zip` dosyasını aç
-2.Açılan dizindeki `dip` dizinini `C:` dizini altına kopyala
-3.images.zip [indir](http://www.diplib.org/download) `C:\dip` dizinine kopyala
###Matlab ortamında çalıştırmak için komut penceresine aşağıdakileri yaz
-1.addpath('C:\dip\common\dipimage')
-2.dip_initialise
-3.dipsetpref('imagefilepath','C:\dip\images')
## EMG

- EMG+SVM ile ilgili çalışmalar: 3 hareket, 7 hareket

## Görüntü

- Elhızının çıkarılması çalışması: markerlı, bulaşık eldiveni, acceglove

## Gait Analysis/Recognition/...

- HumanEva: database, matlab code vs: http://vision.cs.brown.edu/humaneva/download1.html
- GaTech, MIT feature extraction
- HumanID
- EU FP6 projesi
- Rum kesimindeki hocanın [sunumu](http://www.iti.gr/iti/files/document/seminars/Activity_recognition_final.pdf)
- eigenwalker

- bamberg08, "Gait Analysis Using a Shoe-Integrated Wireless Sensor System",Stacy J. Morris Bamberg,IEEE,2008

## Sanal El

- [vhand](http://github.com/19bal/vhand) çalışması
