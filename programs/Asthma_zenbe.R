#Asthma_zenbedata
#作成日:2017/06/16
#作成者:Risa watanabe
############################################

#作業ディレクトリの設定


#csvファイル読み込み

setwd("../rawdata")
getwd()

regi.data<-read.csv("Asthma_registration_170627_1154.csv",na.strings="",as.is=T)
baseline.data<-read.csv("Asthma_baseline_slight_170615_0948.csv",na.strings="",as.is=T)
baselineheavy.data<-read.csv("Asthma_baseline_heavy_170615_0948.csv",na.strings="",as.is=T)

#regi.dataの項目「シート作成時施設名」」と「現担当医」と「症例登録番号」と「年齢」と「通し番号」をDFに入れる
regi<-regi.data[,c(6,14,18,30,32)]
names(regi)
#項目名「シート作成時施設名」を「施設名」に変更
names(regi)[1]<-c("施設名")
#項目名「現担当医」を「担当医名」に変更
names(regi)[2]<-c("担当医名")
names(regi)

#baseline.dataの項目「症例登録番号」と「性別」をDFに入れる
baseline<-baseline.data[,c(18,28)]
names(baseline)
#項目名を「性別.1」から「性別_重症でない」に変更
names(baseline)[2]<-c("性別_重症でない")
names(baseline)

#baselineheavy.dataの項目「症例登録番号」と「性別」をDFに入れる
baselineheavy<-baselineheavy.data[,c(18,28)]
names(baselineheavy)
#項目名を「性別.1」から「性別_重症」に変更
names(baselineheavy)[2]<-c("性別_重症")
names(baselineheavy)

#baselineとbaselineheavyを「症例登録番号」をキーにマージ
sexdata<-merge(baseline,baselineheavy,by="症例登録番号",all=T)

#regiとbaselineを「症例登録番号」をキーにマージ
merge1<-merge(regi,baseline,by="症例登録番号",all=T)
#merge1とbaselineheavyをmerge「症例登録番号」をキーにマージ
merge2<-merge(merge1,baselineheavy,by="症例登録番号",all=T)

#「性別_重症でない」の中で、男性と女性をDFに入れる。
merge2$"性別"<-ifelse((merge2$性別_重症でない=="女性" & is.na(merge2$性別_重症)) | (is.na(merge2$性別_重症でない) & merge2$性別_重症=="女性"),"女性","男性")


#項目名を並べ替える
names(merge2)
asthmadata<-merge2[,c(1,2,3,5,8,4)]

#NAなら空値にして。書き出し
asthmadata[is.na(asthmadata)]<-""
write.csv(asthmadata,"Asthma_zenbe.csv",row.names=F)
