% Skill recommendation System: Module 1 
% AOBD Final Exam - Ratnesh-1401110
clc;
clear all;
close all;

%read the file containing list of all the skills 
[num,skills]= xlsread('skills.xlsx','A1:A10');

%read the file containing list of all the professions 
[num,pos]=xlsread('positions.xlsx','A1:A4');

%read the file containing list of all the users their profession and their skills  
[user_id,user_pos]=xlsread('skills_user','B1:B5');
[user_id,user_skills]=xlsread('skills_user','C1:C5');
c=zeros(length(skills),length(pos));

%We generate the C matrix matrix which contains the information that which skill is present 
%in which profession and how many people of that profession have that skill(weight) 
for i=1:length(pos)
    for j=1:length(user_pos)
        if(strcmp(user_pos(j),pos(i)))
            user_skill_array=strsplit(char(user_skills(j)),',');%to compare string by spliting them with ',' delimiter
            for k=1:length(skills)
                for l=1:length(user_skill_array)
                    if(strcmp(skills(k),user_skill_array(l)))
                       
                        c(k,i)=c(k,i)+1; % assigns the weight in the matrix 
                    end
                end
            end
        end
    end
end
c;

% S x U matrix containing 1 if user possess that skill else 0 
user_skill_mat=zeros(length(skills),length(user_id));
for i=1:length(user_pos)
    for j=1:length(skills)
        user_skill_array=strsplit(char(user_skills(i)),',');
        for k=1:length(user_skill_array)
            if(strcmp(skills(j),user_skill_array(k)))
                user_skill_mat(j,i)=1;
            end
        end
    end
end

user_skill_mat;
disp('Skill Recommendation System: Ratnesh Shah - 1401110');

% Input Skill from User
input_var=input('Please enter your skills: ','s');
input_var=lower(input_var);
input_var=strsplit(char(input_var),',');
user_input_skill=zeros(length(skills),1);

% Create a vector of length as total no. of the skills 
for j=1:length(skills)
    for k=1:length(input_var)
        if(strcmp(skills(j),input_var(k)))
            user_input_skill(j)=1;
        end
    end
end
new_user=zeros(10,4);

new_user(:,1)=user_input_skill;

[r,clm]=size(c);

for i=1:clm
    dist(i)=dot(c(:,i),user_input_skill)/(norm(c(:,i),2)*norm(user_input_skill,2));
end

% Descending order of similarity with the C matrix (gives the column no. of profession which has skills most similar to your skills)
[dist,index]=sort(dist,'descend');
q=1;
r=1;
% gets all the skills of most prefered position
for i = 1:length(skills)
    if c(i,index(1))>=1
        cust_skills(q)=i;
        q=q+1;
    end
    if c(i,index(2)>=1)
        cust_skills_2(r)=i;
        r=r+1;
    end
end

% Top to Profession Recommendation and the top Skills are recommended
first_recommend=zeros(10,1);
second_recommend=zeros(10,1);


for p=1:length(cust_skills)
    first_recommend(cust_skills(p))=1;
end
for p=1:length(cust_skills_2)
    second_recommend(cust_skills_2(p))=1;
end

% If skill is already present in the user than it should not be recommended again so we subtract those skills
first_recommend = first_recommend-user_input_skill;
second_recommend = second_recommend-user_input_skill;
for n = 1:length(second_recommend)
   if second_recommend(n)<0
       second_recommend(n)=0;
   end
end
mat_1 = find(first_recommend);
mat_2 = find(second_recommend);

%Give Output to the User
fprintf('1st preference -->You are recommended to pursue %s profession\n',pos{index(1)}); % Prints the Profession with most similar skills
disp('You are recommend to acquire following skills-->');

for l = 1:length(mat_1)
    disp(skills(mat_1(l))); % Displays the recommended skills in that profession with more prominent skill at the top
end
disp('------------------------------------------------------------------');

% 2nd Preference also shown to the user
fprintf('2nd preference -->You are recommended to pursue %s profession\n',pos{index(2)});
disp('You are recommended to acquire following skills-->');

for l = 1:length(mat_2)
    disp(skills(mat_2(l)));
end



