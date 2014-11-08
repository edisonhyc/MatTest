%
%argv1={Datestart Dateend}
%argv2==Time
%
%%
function [Returncode,Startbar,Endbar]=Func_Finddate(argv1,argv2)
Startbar=0;
Endbar=0;
Startdate=argv1{1};
Enddate=argv1{2};
lensdate=length(Startdate);
lenedate=length(Enddate);
lendata=length(argv2);
for i=1:lendata-1
    if strcmp(Startdate,argv2{i}(1:lensdate))
        Startbar=i;
        for j=i+1:lendata-1
            if strcmp(Enddate,argv2{j}(1:lenedate))
                for k=j+1:lendata
                    if strcmp(Enddate,argv2{k}(1:lenedate))==0 || k==lendata
                        Endbar=k-1;
                        break;
                    end
                end
                break;
            end
        end
        break;
    end
end
if Startbar==0
    Returncode=2;
    return;
end
if Endbar==0
    Returncode=3;
    return;
end
Returncode=0;
end