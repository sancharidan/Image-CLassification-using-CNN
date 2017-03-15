%function [train_images,train_labels]=CIFAR_data_get()
train_1=load('C:\Users\SANCHARI\Documents\CNNclass\cifar-10-batches-mat\data_batch_1.mat');
train_2=load('C:\Users\SANCHARI\Documents\CNNclass\cifar-10-batches-mat\data_batch_2.mat');
train_3=load('C:\Users\SANCHARI\Documents\CNNclass\cifar-10-batches-mat\data_batch_3.mat');
train_4=load('C:\Users\SANCHARI\Documents\CNNclass\cifar-10-batches-mat\data_batch_4.mat');
train_5=load('C:\Users\SANCHARI\Documents\CNNclass\cifar-10-batches-mat\data_batch_5.mat');
train_data=cat(1,train_1.data,train_2.data,train_3.data,train_4.data,train_5.data);
train_images=zeros(32,32,3,50000);

for t=1:50000
    row=1;
    %for red part
    for j=1:32:1024
        train_images(row,:,1,t)=train_data(t,j:j+31);
        row=row+1;
    end
    row=1;
    %for blue part
    for j=1025:32:2048
        train_images(row,:,2,t)=train_data(t,j:j+31);
        row=row+1;
    end
    row=1;
    %for green part
    for j=2049:32:3072
        train_images(row,:,3,t)=train_data(t,j:j+31);
        row=row+1;
    end
end
train_labels=cat(1,train_1.labels,train_2.labels,train_3.labels,train_4.labels,train_5.labels);
save('train_labels_final.mat','train_labels');

%normalizing the images by subtracting mean and dividing by std
% %% calculating mean
meanred=mean(train_images(:,:,1,1:30000),4);
meangreen=mean(train_images(:,:,2,1:30000),4);
meanblue=mean(train_images(:,:,3,1:30000),4);
stdred=std(train_images(:,:,1,1:30000),0,4);
stdgreen=std(train_images(:,:,2,1:30000),0,4);
stdblue=std(train_images(:,:,3,1:30000),0,4);
train_imagesf=zeros(size(train_images));
for i=1:50000
    train_imagesf(:,:,1,i)=(train_images(:,:,1,i)-meanred)./stdred;
    train_imagesf(:,:,2,i)=(train_images(:,:,2,i)-meangreen)./stdgreen;
    train_imagesf(:,:,3,i)=(train_images(:,:,3,i)-meanblue)./stdblue;
end
save('train_data_final.mat','train_imagesf');
