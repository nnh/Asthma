#Asthma_zenbedata_revision
#作成日:2017/11/29
#作成者:Risa watanabe
############################################

#############################################
#変更設定箇所
#############################################

#ファイル名の設定
#ここにcsvファイル名を入力する
FN1 <- "Asthma_registration_180601_1000.csv"
FN2 <- "Asthma_baseline_slight_180601_1000.csv"
FN3 <- "Asthma_baseline_heavy_180601_1000.csv"

#csvファイル読み込み
#csv置いてある場所を毎回修正。\を/に。

setwd("//ARONAS/Datacenter/Trials/NHO/NHOM-Asthma/対応表/20180601/rawdata")
getwd()


#############################################
#以下は変更しない
#############################################

regi_data <- read.csv(FN1, na.strings = "", as.is = T)
baseline_data <- read.csv(FN2, na.strings = "", as.is = T)
baselineheavy_data<-read.csv(FN3, na.strings = "", as.is = T)

#regi_dataの項目「シート作成時施設名」と「シート作成時担当医」と「症例登録番号」と「年齢」と「通し番号」をDFに入れる
regi <- regi_data[, c(4, 7, 9, 15, 17)]

#項目名「シート作成時施設名」を「施設名」に変更
names(regi)[1] <- c("施設名")

#項目名「シート作成時担当医」を「担当医名」に変更
names(regi)[2] <- c("担当医名")

#baseline_dataの項目「症例登録番号」と「性別」をDFに入れる
baseline <- baseline_data[, c(9, 13)]

#項目名を「性別.1」から「性別_重症でない」に変更
names(baseline)[2] <- c("性別_重症でない")

#baselineheavy_dataの項目「症例登録番号」と「性別」をDFに入れる
baselineheavy <- baselineheavy_data[, c(9, 13)]

#項目名を「性別.1」から「性別_重症」に変更
names(baselineheavy)[2] <- c("性別_重症")

#regiとbaselineを「症例登録番号」をキーにマージ
merge1 <- merge(regi, baseline, by = "症例登録番号", all = T)
#merge1とbaselineheavyをmerge「症例登録番号」をキーにマージ
merge2 <- merge(merge1, baselineheavy, by = "症例登録番号", all = T)

#「性別_重症でない」と「性別_重症」の中で、男性と女性をDFに入れる。

merge2$"性別" <- ifelse(!is.na(merge2$性別_重症),merge2$性別 <- merge2$性別_重症,
       ifelse(!is.na(merge2$性別_重症でない),merge2$性別 <- merge2$性別_重症でない,NA))


#項目名を並べ替える
asthmadata <- merge2[, c(1, 2, 3, 5, 8, 4 )]

#NAなら空値にして。書き出し
setwd("../output")
asthmadata[is.na(asthmadata)] <- ""
write.csv(asthmadata, "Asthma_zenbe.csv", row.names = F)