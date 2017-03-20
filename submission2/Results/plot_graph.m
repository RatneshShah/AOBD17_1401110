n=[10 20 30 40 50];

ppca1=[0.095 0.1298 0.1582 0.1783 0.2018];
rpca1=[0.0467 0.0523 0.061 0.07906 0.1227];

ppcat=[1.11	1.271 1.272	1.193 1.1123];
rpcat=[2.1464 2.1611 2.234 2.667 2.7667];

ppcame=[0.0195	0.027	0.0329	0.038	0.04328];
rpcame=[0.3115	0.306	0.30049	0.318299	0.33];

ppcamt=[1.2884	1.624	1.767	1.8016	1.99];
rpcamt=[2.05	2.46	2.677	2.804	2.987];


subplot(221);
plot(n,ppca1,'r',n,rpca1,'b');
legend('PPCA','RPCA');
xlabel('Percentage of Corrupted Entries')
ylabel('Mean Square Error')
title('Error plot for recovering corrupted image using PPCA and RPCA')

subplot(223);
plot(n,ppcat,'r',n,rpcat,'b');
legend('PPCA','RPCA');
xlabel('Percentage of Corrupted Entries')
ylabel('Time (sec)')
title('Time Taken for recovering corrupted image using PPCA and RPCA')


subplot(222);
plot(n,ppcame,'r',n,rpcame,'b');
legend('PPCA','RPCA');
xlabel('Percentage of Missing Entries')
ylabel('Mean Square Error')
title('Error plot for recovering Missing Entries in an image using PPCA and RPCA')


subplot(224);
plot(n,ppcamt,'r',n,rpcamt,'b');
legend('PPCA','RPCA');
xlabel('Percentage of Corrupted Entries')
ylabel('Time (sec)')
title('Time Taken for recovering Missing Entries in an image using PPCA and RPCA')