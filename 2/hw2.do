//导入数据文件，设置工作文件夹
use "C:\Users\11747\Desktop\学习资料\20上\计量经济学\statafile\empex_tb\cps92_08.dta", clear
cd C:\Users\11747\Desktop\学习资料\20上\计量经济学\works\2

//根据CPI计算出1992-2018年的GDP缩减指数，并依次算出该两年以2018年价格度量的AHE:real_ahe
gen gdp_deflator = 215.2/140.3
gen real_ahe = ahe * gdp_deflator if year == 1992 //1992年AHE乘以GDP缩减指数
replace real_ahe = ahe if year == 2008 //2018年AHE保持不变

//logout 将结果导出
//ttest varname [if] , by(groupvar) 即对groupvar中的各个变量，在if条件下的值进行t检验
*a.
logout, save(a) word replace : ttest ahe, by(year)

*b.
logout, save(b) word replace : ttest real_ahe, by(year)

*d.
logout, save(d) word replace : ttest ahe if year == 2008, by(bachelor)

*e.
logout, save(e) word replace : ttest real_ahe if year == 1992, by(bachelor)

*f.
logout, save(f) word replace : by bachelor, sort: ttest real_ahe, by(year)

*g.
logout, save(g) word replace : by year, sort: ttest real_ahe if bachelor == 0, by(female)