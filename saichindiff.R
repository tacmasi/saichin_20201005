y<-read.csv("all_gyudon_colnameon.csv",header=T,na.strings="NA")
#y[which(y[2]=="")]
#[1]  838 1187 1224 1426 2747 2874
# y[which(y[2]==""),3]
#[1] "吉野家 16号線春日部店"   "吉野家 産業道路美原店"  
#[3] "吉野家 小田急町田北口店" "吉野家 東戸塚西口店"    
#[5] "すし松　三芳PA店"        "松屋　名駅西店"         
#> y[which(y[2]==""),2]
#[1] "" "" "" "" "" ""

#データ欠け対応
y[838,2]="埼玉県"
y[1187,2]="北海道"
y[1224,2]="東京都"
y[1426,2]="神奈川"
y[2747,2]="埼玉県"
y[2874,2]="愛知県"

x<-read.table("saichin2012_2020.txt",header=T)
#pref 2012 2013...
prefs <- x[1]

#diff of minimum wage
diffMW <- y

dimy <- dim(y)
for (j in 5:dimy[2]){
		print(j)
	YYYY <- as.integer(substr(names(y)[j],2,5))
	MM <- as.integer(substr(names(y)[j],6,7))
	
	saichinCol <- YYYY - 2012 + 1
	if (MM >= 10){
		saichinCol <- saichinCol + 1
		}
	minWages = x[,saichinCol]
	for (i in 1:dimy[1]){
		if (!is.na(diffMW[i,j])){
			#row of pref
			prefrow <- which(x == y[i,2])
			#minimumWage
			minWage <- minWages[prefrow]
			diffMW[i,j] <- diffMW[i,j] - minWage
			}
		}
	}
write.csv(file="diff_saichin.csv",diffMW)


