# Multi-objective
# Application of Multi-objective Optimization Algorithm in Cluster Task Scheduling Problem：
1.多目标优化算法：采用NSGA-II算法：
 
  参考文献：(1) A Fast and Elitist Multiobjective Genetic Algorithm:NSGA-II Kalyanmoy Deb, Associate Member, IEEE, Amrit Pratap, Sameer                    Agarwal, and T. Meyarivan
  
  参考代码：(1) http://www.iitk.ac.in/kangal/codes.shtml
          
          (2) https://ww2.mathworks.cn/matlabcentral/fileexchange/10429-nsga-ii-a-multi-objective-optimization-algorithm?s_tid=prof_contriblnk
          
           
2.集群任务调度：
  (1)采用异构集群模型，符合users->Tasks->Nodes模式。
   
   注：每个Node的处理能力不同，在此引用Hadoop中slot的概念，即每个Node的slot数是不同的。
     
   大致模型如下：(不好意思，不会传图片)
   
  (2)目标函数的选取：
  
     I.用户层面：任务的整体完成时间 （最小化）
    II.集群层面：集群各节点的负载均衡的标准差 （最小化）
    
    
 更多问题：Contact：colynhn@gmail.com or colynhn@foxmail.com
            
   
