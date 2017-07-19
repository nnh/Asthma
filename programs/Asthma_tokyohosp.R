#Asthmadata_for_tokyohosp
#作成日:2017/06/28
#作成者:Risa watanabe
############################################

# 作業ディレクトリの設定


#ファイル名の設定
#ここにcsvファイル名を入力する
filename <- "Asthma_registration_170627_1154.csv"

# csvファイル読み込み
setwd("../rawdata")
getwd()

regi_data <- read.csv(filename, na.strings = "", as.is = T)

# regi_dataの項目「シート作成時施設名」」と「現担当医」と「症例登録番号」と「通し番号」をDFに入れる
regi <- regi_data[, c(6,14,18,32)]

# 項目名「シート作成時施設名」を「施設名」に変更
names(regi)[1] <- c("施設名")

# 項目名「現担当医」を「担当医名」に変更
names(regi)[2] <- c("担当医名")


# 項目名を並べ替える
asthmadata <- regi[, c(3, 1, 2, 4)]


#NAなら空値にして。書き出し
asthmadata[is.na(asthmadata)] <- ""
write.csv(asthmadata, "Asthma_tokyohosp.csv", row.names=F)