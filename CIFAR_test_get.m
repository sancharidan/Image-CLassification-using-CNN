test=load('C:\Users\SANCHARI\Documents\CNNclass\cifar-10-batches-mat\test_batch.mat');
test_data=test.data;
test_labels=test.labels;
test_images=zeros(32,32,3,10000);
test_imagesf=zeros(32,32,3,10000);

for t=1:10000
    row=1;
    %for red part
    for j=1:32:1024
        test_images(row,:,1,t)=test_data(t,j:j+31);
        row=row+1;
    end
    row=1;
    %for blue part
    for j=1025:32:2048
        test_images(row,:,2,t)=test_data(t,j:j+31);
        row=row+1;
    end
    row=1;
    %for green part
    for j=2049:32:3072
        test_images(row,:,3,t)=test_data(t,j:j+31);
        row=row+1;
    end
end
save('test_labels_final.mat','test_labels');
for i=1:10000
    test_imagesf(:,:,1,i)=(test_images(:,:,1,i)-meanred)./stdred;
    test_imagesf(:,:,2,i)=(test_images(:,:,2,i)-meangreen)./stdgreen;
    test_imagesf(:,:,3,i)=(test_images(:,:,3,i)-meanblue)./stdblue;
end
save('test_data_final.mat','test_imagesf');
