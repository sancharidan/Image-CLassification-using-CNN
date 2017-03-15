%testing data
data=load('C:\Users\SANCHARI\Documents\CNNclass\test_data_final.mat');
test_dataf=data.test_imagesf;
labels=load('C:\Users\SANCHARI\Documents\CNNclass\test_labels_final.mat');
test_labelf=labels.test_labels;
%forward prop
at7=zeros(10000,10);
outt=zeros(10000,10);
correct1=0;
correct5=0;
for i=1:10000
    ct1=Conv_forward_prop(test_dataf(:,:,:,i),filt1,1)+bias1;
    pt2=pool_forward_prop(ct1,2);
    ct3=Conv_partial_forward_prop(pt2,filt3)+bias3;
    pt4=pool_forward_prop(ct3,4);
    ct5i=Conv_forward_prop(pt4,filt5,5);
    n=18;
    ct5=zeros(1,18);
    for k=1:18
        ct5(1,k)=ct5i(1,1,k);
    end
    ct5=ct5+bias5;
    fct6=(ct5*weights6)+bias6;%fully connected layer
    at7(i,:)=tanh(fct6);
    outt(i,test_labelf(i)+1)=1;
    [M1,I1]=max(at7(i,:));
    [M2,I2]=max(outt(i,:));
    if I1==I2
        correct1=correct1+1;
    end
    comp=at7(i,I2);
    cnt5=0;
    for j=1:10
        if comp>at7(i,j)
            cnt5=cnt5+1;
        end
    end
    if cnt5>=5
        correct5=correct5+1;
    end
%     label_names=load('C:\Users\SANCHARI\Documents\CNNclass\cifar-10-batches-mat\batches.meta.mat');
%     print(label_names.label_names{I+1});
end
accuracy1=correct1/100;
accuracy5=correct5/100;
