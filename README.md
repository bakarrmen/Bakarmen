# SEI TESTNET | KURULUM REHBERİ | INSTALL GUIDE
![first](https://cdn.discordapp.com/attachments/987875932129886231/987875966070161458/seicover.jpg)

# İLK KURULUM | FIRST INSTALLATION

## İşletim Sistemi / Operating System 

Linux Ubuntu 20.04

## Sistem Gereksinimleri / System Requirements

|    Bellek/Ram   |       İşlemci/Cpu      |      Disk      |   Network/Ağ           |
|-------------|----------------|----------------|----------------|
|     4GB     |   Quad-Core    |     250GB      |  1Gbps/100Mbps |

## Sunucu Kurulumu | Server Installation

[TR]
Sunucunuza bu komutları sırasıyla girip kurulama başlayın.

[EN]
Enter these commands on your server in order and start the installation.

`sudo su`
 
`cd`
  
`apt install screen -y`
 
`screen -S node`

`wget -q -O sei-install-lalilax.sh https://raw.githubusercontent.com/lalilax/sei-test-net-kurulum/main/sei-install-lalilax.sh && chmod +x sei-install-lalilax.sh && sudo /bin/bash sei-install-lalilax.sh`

![two](https://cdn.discordapp.com/attachments/987875932129886231/988094872080756797/unknown.png)

[TR]
Otomatik kurulum node adı soracak oraya node adınızı girin. (Not: Node adınızı mutlaka bir yere not ediniz.)

[EN]
Automatic installation will ask for a node name, enter your node name there. (Note: Be sure to write down your node name.)

![three](https://cdn.discordapp.com/attachments/987875932129886231/988095898074611812/unknown.png)

[TR]
Kurulum tamamlandıktan sonra sunucunuz blok tarıyor mu diye kontrol etmelisiniz. Alttaki komutu yazarak loglarınızı izleyebilirsiniz.

[EN]
After the installation is complete, you should check if your server is scanning blocks. You can monitor your logs by typing the command below.

`journalctl -fu seid -o cat `

![4](https://cdn.discordapp.com/attachments/987875932129886231/988098955302801531/111111.png)

[TR]
Eğer bu şekilde blok tarama kısmında hata alıyorsanız bir süre beklemeniz gerekmekte peer listesi eşlemesi biraz zaman alabiliyor 5-15 dakika arası

[EN]
If you get an error in the block scanning part in this way, you need to wait for a while, peer list matching may take some time, between 5-15 minutes.

![5](https://cdn.discordapp.com/attachments/987875932129886231/988098954975666216/22222.png)

[TR]
Bir süre sonra loglarınız yukarıdaki resim gibi olacaktır yani bloklarınızı taramaya başlayacaktır. Yukarıda örnek bir fotoğraf ekledim kırmızı alan içine aldığım yer height yazan kısmın yanındaki rakam taradığınız blok sayısını gösterir 153.000 blok sayısına gelene kadar bir süre beklemeniz gerekmtektedir.

153 bin blok taradıktan sonra bir hata alacaksınız bu hatayı aldıktan sonra sei networkün yeni sürümünü kurup blok taramaya devam etmeniz gerekiyor.
CTRL tuşuna basılı tutarak C tuşuna bastığınızda konsoldan çıkış yapabilirsiniz

[EN]
After a while, your logs will be like the picture above, that is, it will start scanning your blocks. I added a sample photo above. The number next to the part that says height, where I put it in the red area, shows the number of blocks you have scanned. You have to wait for a while until the number of blocks is 153,000.

After scanning 153 thousand blocks, you will receive an error. After receiving this error, you need to install the new version of sei network and continue block scanning.
You can exit the console by holding down the CTRL key and pressing the C key.

# SURUM GUNCELLEMESI 1.0.3 | SEI VERSION UPDATE 1.0.3

