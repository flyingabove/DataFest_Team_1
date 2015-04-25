merged.data <- merge(visitor_clean, transactions_clean, by = "visitor_key")
merged.data2 <- merge(merged.data, shopping, by = "visitor_key")
merged.data2.final <- merged.data2[!duplicated(merged.data2[, names(merged.data2)[1]]), ]
merged.data3 <- merge(merged.data2.final, leads_clean, by = "visitor_key")
merged.data3.final <- merged.data3[!duplicated(merged.data3[, names(merged.data3)[1]]), ]
merged.data4 <- merge(merged.data3.final, configuration, by = "visitor_key")
merged.data4.final <- merged.data4[!duplicated(merged.data4[, names(merged.data4)[1]]), ]
save(merged.data4.final, file="merged_data.RData")

n_occur <- data.frame(table(shopping$visitor_key))
keys <- shopping[shopping$visitor_key %in% n_occur$Var1[n_occur$Freq > 1], ]
