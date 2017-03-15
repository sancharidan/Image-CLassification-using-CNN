data=load('C:\Users\SANCHARI\Documents\CNNclass\train_data_final.mat');
train_data=data.train_imagesf;
labels=load('C:\Users\SANCHARI\Documents\CNNclass\train_labels_final.mat');
train_label=labels.train_labels;
filt1=zeros(5,5,3,10);
bias1=zeros(28,28,10);
for m=1:10
    filt1(:,:,:,m)=randn([5,5,3])*sqrt(2/(32*32*10));%10 filters of 5X5X3
end
filt3=zeros(5,5,9);
bias3=zeros(10,10,18);
for m=1:9
    filt3(:,:,m)=randn(5)*sqrt(2/(14*14*9));%9 filters for second conv layer
end
filt5=randn(5,5,18);
bias5=zeros(1,18);
for m=1:18
    filt5(:,:,m)=randn(5)*sqrt(2/(5*5*18));
end
weights6=randn([18,10])*sqrt(2/(18*10));
bias6=zeros(1,10);
alpha=0.01;%learning rate- final (almost!)
v6=0;
v5=0;
v3=0;
v1=0;
mu=0.9;
wd=0.0005;
epoch_nums=3;
error=zeros(500*50,1);
del6=zeros(1,10);
errcnt=1;
for epoch=1:epoch_nums
    %alpha=alpha-0.01*alpha;
    for i=1:100:50000
        %j=uint32(randi([i i+99],[1 1]));
        grad6acc=0;
        grad5acc=0;
        grad3acc=0;
        grad1acc=0;
        for j=i:i+99
            
            %forward propagation for selected image
            c1=Conv_forward_prop(train_data(:,:,:,j),filt1,1)+bias1;
            p2=pool_forward_prop(c1,2);
            c3=Conv_partial_forward_prop(p2,filt3)+bias3;
            p4=pool_forward_prop(c3,4);
            c5i=Conv_forward_prop(p4,filt5,5);
            n=18;
            c5=zeros(1,18);
            for k=1:18
                c5(1,k)=c5i(1,1,k);
            end
            c5=c5+bias5;
            fc6=(c5*weights6)+bias6;%fully connected layer
            a7=tanh(fc6);
            out=zeros(size(a7));
            out(train_label(j)+1)=1;
            error(errcnt)=error(errcnt)+sum((out-a7).^2)/10;
            del6=output_backprop(a7,out,fc6);
            %backward propagation for each image
            [grad6,del5]=fc_backprop(c5,del6,weights6);
            [grad5,del4]=conv_backprop(del5,p4,filt5);
            [del3]=pool_backprop(del4,c3,p4);
            [grad3,del2]=conv_partial_backprop(del3,p2,filt3);
            [del1]=pool_backprop(del2,c1,p2);
            [grad1]=conv_backprop_firstlayer(train_data(:,:,:,j),filt1,del1);
            grad6acc=grad6acc+grad6;
            grad5acc=grad5acc+grad5;
            grad3acc=grad3acc+grad3;
            grad1acc=grad1acc+grad1;
        end
        grad6acc=grad6acc/100;
        grad5acc=grad5acc/100;
        grad3acc=grad3acc/100;
        grad1acc=grad1acc/100;
        error(errcnt)=error(errcnt)/100;
        errcnt=errcnt+1;
        v6=mu*v6-0.008*weights6-0.001*grad6;
        weights6=weights6+v6;
        bias6=bias6+(0.008*bias6+0.001*del6);
        v5=mu*v5-0.0002*grad5;
        filt5=filt5+v5;
        bias5=bias5+(0.0002*del5);
        v3=mu*v3-0.0002*grad3;
        filt3=filt3+v3;
        bias3=bias3+(0.0002*del3);
        v1=mu*v1-0.0001*grad1;
        filt1=filt1+v1;
        bias1=bias1+(0.0001*del1);
    end
    plot(error);
    ylabel('error');
    hold on;
end
