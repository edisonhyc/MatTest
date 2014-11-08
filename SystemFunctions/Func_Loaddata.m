%
%argv='file.csv'
%
%%
function [Returncode,Time,Open,High,Low,Close,Volume,Position]=Func_Loaddata(argv)
fid = fopen(argv);
title = textscan(fid, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s',1,'delimiter', ',');
scanformat='';
for i=1:length(title)
    if strcmp(title{i},'')
        break;
    end
    if strcmp(title{i},'Time')
        scanformat=strcat(scanformat,'%s  ');
    else
        scanformat=strcat(scanformat,'%f  ');
    end
end
data = textscan(fid, scanformat ,'delimiter', ',');
for i=1:length(data)
    if strcmp(title{i},'Time')
        Time=data{i};
    end
    if strcmp(title{i},'Open')
        Open=data{i};
    end
    if strcmp(title{i},'High')
        High=data{i};
    end
    if strcmp(title{i},'Low')
        Low=data{i};
    end
    if strcmp(title{i},'Close')
        Close=data{i};
    end
    if strcmp(title{i},'Volume')
        Volume=data{i};
    end
    if strcmp(title{i},'Position')
        Position=data{i};
    end
end
Returncode=0;
fclose(fid);
end