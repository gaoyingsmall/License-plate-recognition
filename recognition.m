%�������ڵ�������������
close all
clc

%��ȡһ����λ��ĳ���ͼ��
[filename,filepath]=uigetfile('.jpg','������һ����λ��ĳ���ͼ��');
%ƴ��filepath��filename�õ��������ļ���
file=strcat(filepath,filename);
dw=imread(file);

liccode=char(['0':'9' 'A':'Z' '��ԥ��³']);  %�����Զ�ʶ���ַ������  
SubBw2=zeros(40,20);
l=1;
for I=1:7
      ii=int2str(I);
      prefix=strcat(filepath,'�ַ�');
      ii=strcat(prefix,ii);
      ii=strcat(ii,'.jpg');
      t=imread(ii);
      SegBw2=imresize(t,[40 20],'nearest');
        if l==1                 %��һλ����ʶ��
            kmin=37;
            kmax=40;
        elseif l==2             %�ڶ�λ A~Z ��ĸʶ��
            kmin=11;
            kmax=36;
        else l>=3               %����λ�Ժ�����ĸ������ʶ��
            kmin=1;
            kmax=36;
        
        end
        
        for k2=kmin:kmax
            fname=strcat('�ַ�ģ��\',liccode(k2),'.jpg');
            SamBw2 = imread(fname);
            for  i=1:40
                for j=1:20
                    SubBw2(i,j)=SegBw2(i,j)-SamBw2(i,j);
                end
            end
           % �����൱������ͼ����õ�������ͼ
            Dmax=0;
            for k1=1:40
                for l1=1:20
                    if  ( SubBw2(k1,l1) > 0 | SubBw2(k1,l1) <0 )
                        Dmax=Dmax+1;
                    end
                end
            end
            Error(k2)=Dmax;
        end
        Error1=Error(kmin:kmax);
        MinError=min(Error1);
        findc=find(Error1==MinError);
        Code(l*2-1)=liccode(findc(1)+kmin-1);
        Code(l*2)=' ';
        l=l+1;
end
figure(1),imshow(dw),title (['���ƺ���:', Code],'Color','b');