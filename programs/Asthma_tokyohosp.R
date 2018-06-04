#Asthmadata_for_tokyohosp_revision
#作成日:2017/11/29
#作成者:Risa watanabe
############################################

#############################################
#変更設定箇所
#############################################

#ファイル名の設定
#ここにcsvファイル名を入力する
filename <- "Asthma_registration_180601_1000.csv"

# csvファイル読み込み
#csv置いてある場所を毎回修正。\を/に。
setwd("//ARONAS/Datacenter/Trials/NHO/NHOM-Asthma/対応表/20180601/rawdata")
getwd()

#############################################
#以下は変更しない
#############################################
regi_data <- read.csv(filename, na.strings = "", as.is = T)

# regi_dataの項目「シート作成時施設名」」と「シート作成時担当医」と「症例登録番号」と「通し番号」をDFに入れる
regi <- regi_data[, c(4,7,9,17)]

# 項目名「シート作成時施設名」を「施設名」に変更
names(regi)[1] <- c("施設名")

# 項目名「シート作成時担当医」を「担当医名」に変更
names(regi)[2] <- c("担当医名")


# 項目名を並べ替える
asthmadata <- regi[, c(3, 1, 2, 4)]


#NAなら空値にして。書き出し
setwd("../output")
asthmadata[is.na(asthmadata)] <- ""
write.csv(asthmadata, "Asthma_tokyohosp.csv", row.names=F)