clc;
clear all;
close all;
[num,skills]= xlsread('skills.xlsx','A1:A10');
[num,pos]=xlsread('positions.xlsx','A1:A4');
[user_id,user_pos]=xlsread('skills_user','B1:B6');
[user_id,user_skills]=xlsread('skills_user','C1:C6');
c=zeros(length(skills),length(pos));
for i=1:length(pos)
    for j=1:length(user_pos)
            if(strcmp(user_pos(j),pos(i)))
                user_skill_array=strsplit(char(user_skills(j)),',');
                for k=1:length(skills)
                    for l=1:length(user_skill_array)
                        if(strcmp(skills(k),user_skill_array(l)))
                        c(k,i)=c(k,i)+1;
                        end
                    end
                end
            end
    end
end

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
profession=input('Enter your profession: ','s');
q=1;
for  i = 1:length(pos)
    if(strcmp(pos(i),profession))
         for j = 1:length(skills)
            if c(j,i)>=1
                cust_skills_wt(q)=c(j,i);
                cust_skills(q)=j;
                q=q+1;
            end
         end
    end
end
[cust_skills_wt,in]=sort(cust_skills_wt,'descend');
disp('Recommended skills:(Ordered from High Preferance to Low Preference) ')
for n=1:length(in)
   recommended_skills(n)= skills((cust_skills(in(n))));
end

disp(recommended_skills);
