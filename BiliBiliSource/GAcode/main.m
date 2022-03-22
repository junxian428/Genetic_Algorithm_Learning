clc;clear

nVar = 100; % 自变量长度
nPop = 30; % 种群规模
maxIt = 2000; % 最大迭代次数
nPc = 0.8; % 子代比例
nC = round(nPop * nPc / 2) * 2; % 子代规模
nMu = 0.01; % 变异概念


% 结果存放模板
template.x = [];
template.y = [];

% 父代种群结果存放
Parent = repmat(template, nPop, 1);


% 初始化种群
for i = 1 : nPop
    
    Parent(i).x = randi([0, 1], 1, nVar);
    Parent(i).y = fun(Parent(i).x);
    
end

for It = 1 : maxIt
    
    % 子代种群结果存放数组
    Offspring = repmat(template, nC/2, 2);
    
    for j = 1 : nC / 2     
        
        % 选择
        p1 = selectPop(Parent);
        p2 = selectPop(Parent);
        
        % 交叉
        [Offspring(j, 1).x, Offspring(j, 2).x] = crossPop(p1.x, p2.x);
        
    end
    
    Offspring = Offspring(:);
    
    % 变异
    for k = 1 :nC
        Offspring(k).x = mutatePop(Offspring(k).x, nMu);
        Offspring(k).y = fun(Offspring(k).x);
    end
    
    % 合并种群
    newPop = [Parent; Offspring];
    
    % 排序
    [~, so] = sort([newPop.y], 'ascend');
    newPop = newPop(so);
    
    % 筛选
    Parent = newPop(1 : nPop);
    
    disp(['迭代次数：', num2str(It), '， 最小值为：', num2str(Parent(1).y)])
    
end


