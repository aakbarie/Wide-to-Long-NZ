library(tidyr)

meta_data = read.csv("C:\\Users\\Akbar Akbari Esfahan\\Google Drive\\Mikes\\Code-for-NZ\\layer_depth.csv",header=T)
setwd("C:\\Users\\Akbar Akbari Esfahan\\Google Drive\\Mikes\\Code-for-NZ")
files     <- list.files(pattern=".csv")
files

create_f = function(file)
{
        data = as.data.frame(lapply(file, read.csv,header=T))
        dim(data)
        temp1 = data[,1:24]
        data_long <- gather(temp1, depth, resistivity, res1:res21)
        data_long$depth = as.character(data_long$depth)
        
        for(i in 1:length(meta_data[,1]))
        {
                data_long$Layer[data_long$depth == meta_data[i,3]] = meta_data[i,1]
                data_long$Thick[data_long$depth == meta_data[i,3]] = meta_data[i,2]
                data_long$depth[i]=data_long$DEM[i] - data_long$Thick[i]
        }
        
        write.csv(data_long,paste(file,"_short.csv"),row.names=F)
        #For all res values
        data_long <- gather(data, depth, resistivity, res1:res24)
        data_long$depth = as.character(data_long$depth)
        
        for(i in 1:length(meta_data[,1]))
        {
                data_long$Layer[data_long$depth == meta_data[i,3]] = meta_data[i,1]
                data_long$Thick[data_long$depth == meta_data[i,3]] = meta_data[i,2]
                data_long$depth[i]=data_long$DEM[i] - data_long$Thick[i]
        }
        
        
        write.csv(data_long,paste(file,"_long.csv"),row.names=F)
        
}

create_f("Morrill_block_test_75%(2)_voxler.csv")
create_f("Morrill_block_test_75%(1)_voxler.csv")
create_f("Morrill_block_test_known_75%(2)_voxler.csv")
create_f("Morrill_block_test_known_75%(1)_voxler.csv")