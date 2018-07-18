---
layout: post
title: My First Kaggle Competition (Part Two)
---

This is the second part in a two-part series. For part one, click [here](https://michaele919.github.io/2018-06-10-my-first-kaggle-competition-part-one/).

Before I continue I'd like to point out that this is not a tutorial on machine learning or Scikit-Learn of any kind. If you would like to read more about those topics, I'll suggest selecting a link or two in the Resources dropdown in the top right.

Now, we get to the good stuff- the code. Or, at least a summary of the code. There is too much to go line by line, so I'll just point out the significant parts. Open up the code [here](https://github.com/MichaelE919/kaggle-ncaa-ml-2018-mens/blob/master/NCAA_MoneyBall.py) and follow along.

Now, I had never done one of these Kaggle competitions so I wasn't sure at first what to do. I spent some time browsing over some of the early submissions and tutorials to determine a good approach. I looked at everything from simple predictions that were based on point differential to basic stats such as shooting and turnover percentage to some serious moneyball type stuff. I read about people such as Jeff Sagarin and Dean Oliver and terms such as the Four Factors, Elo Rating, and Offensive Efficiency popped up in several articles.

After playing around and experimental with a few methods I eventually decided to use the same metrics that are used in my previous project, the [NCAA Stats Webscaper](https://github.com/MichaelE919/ncaa-stats-webscraper). I decided on the following metrics (which became the feature set for the machine learning model):
* [The Four Factors](https://www.nbastuffer.com/analytics101/four-factors/)
* [Player Impact Estimate (PIE)](https://masseybasketball.blogspot.com/2013/07/player-impact-estimate.html)
* [Offensive Efficiency](https://www.nbastuffer.com/analytics101/offensive-efficiency/)
* [Defensive Efficiency](https://www.nbastuffer.com/analytics101/defensive-efficiency/)
* [Defensive Rebounding Percentage](https://www.nbastuffer.com/analytics101/defensive-rebounding-percentage/)
* [Assist Ratio](https://www.nbastuffer.com/analytics101/assist-ratio/)
* Free Throw Percentage
* Score Differential
* [Rating Percentage Index (RPI)](https://en.wikipedia.org/wiki/Rating_Percentage_Index)
* Tournament Seed
* Win Percentage

Using this feature set, my model did a horrible job at predicting upsets (only a couple) and consequently performed terribly. I should have known that a March Madness tournament with very few upsets is just not that likely (you can always count on several), and this past tournament there were a lot. Actually, my overall rank in the competition wasn't that bad. I placed 498 out of 934 teams, which is not terrible. However, I used the same submission to fill out my annual office bracket pool, and that failed with flying colors.

After the submission deadline and while the tournament was playing out, I did a little reading and continued to tinker with my model. After some research I added 
* [Adjusted Offensive Efficiency](https://cbbstatshelp.com/efficiency/adjusted-efficiency/)
* [Adjusted Defensive Efficiency](https://cbbstatshelp.com/efficiency/adjusted-efficiency/)
* [Adjusted Efficiency Margin](https://cbbstatshelp.com/ratings/adjem/)
* Offensive Rebound to Turnover Margin

I found that adding these four features made for a much better performing model, predicting many of the actual upsets.

The first part leads to creating a vector containing all the features for each team in every season from 2003-2018:
<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table style="font-size:75%" border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Season</th>
      <th>TeamID</th>
      <th>Seed</th>
      <th>OrdinalRank</th>
      <th>PIE</th>
      <th>eFGP</th>
      <th>ToR</th>
      <th>ORP</th>
      <th>FTR</th>
      <th>4Factor</th>
      <th>AdjO</th>
      <th>AdjD</th>
      <th>AdjEM</th>
      <th>DRP</th>
      <th>ORTM</th>
      <th>AR</th>
      <th>FTP</th>
      <th>PtsDf</th>
      <th>WinPCT</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2003</td>
      <td>1328</td>
      <td>1</td>
      <td>3</td>
      <td>0.604965</td>
      <td>0.512124</td>
      <td>0.155078</td>
      <td>0.347284</td>
      <td>0.332030</td>
      <td>0.362880</td>
      <td>112.1</td>
      <td>89.1</td>
      <td>23.01</td>
      <td>0.709854</td>
      <td>0.333333</td>
      <td>0.153606</td>
      <td>0.714351</td>
      <td>11.000000</td>
      <td>0.800000</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2003</td>
      <td>1448</td>
      <td>2</td>
      <td>7</td>
      <td>0.637398</td>
      <td>0.511972</td>
      <td>0.178941</td>
      <td>0.429724</td>
      <td>0.472499</td>
      <td>0.406344</td>
      <td>114.5</td>
      <td>94.6</td>
      <td>19.87</td>
      <td>0.687237</td>
      <td>-0.344828</td>
      <td>0.147679</td>
      <td>0.755330</td>
      <td>10.793103</td>
      <td>0.827586</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2003</td>
      <td>1393</td>
      <td>3</td>
      <td>9</td>
      <td>0.604162</td>
      <td>0.515151</td>
      <td>0.160408</td>
      <td>0.385242</td>
      <td>0.393873</td>
      <td>0.382292</td>
      <td>114.4</td>
      <td>91.1</td>
      <td>23.28</td>
      <td>0.630790</td>
      <td>0.689655</td>
      <td>0.146059</td>
      <td>0.687824</td>
      <td>10.206897</td>
      <td>0.827586</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2003</td>
      <td>1257</td>
      <td>4</td>
      <td>11</td>
      <td>0.633058</td>
      <td>0.528861</td>
      <td>0.156505</td>
      <td>0.356053</td>
      <td>0.418922</td>
      <td>0.384719</td>
      <td>115.8</td>
      <td>93.0</td>
      <td>22.75</td>
      <td>0.664037</td>
      <td>-0.166667</td>
      <td>0.162239</td>
      <td>0.690997</td>
      <td>13.366667</td>
      <td>0.800000</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2003</td>
      <td>1280</td>
      <td>5</td>
      <td>24</td>
      <td>0.643001</td>
      <td>0.521359</td>
      <td>0.197467</td>
      <td>0.383446</td>
      <td>0.323860</td>
      <td>0.383178</td>
      <td>107.4</td>
      <td>85.8</td>
      <td>21.53</td>
      <td>0.695785</td>
      <td>-2.966667</td>
      <td>0.154033</td>
      <td>0.666941</td>
      <td>10.000000</td>
      <td>0.700000</td>
    </tr>
  </tbody>
</table>
</div>

Next, the process is to isolate the winning and losing teams and create two new datasets with an added result column: one is the difference in feature vectors of the winners minus losers with a result of "1"; the other is losers minus winners with a result of "0".

Finally, concatenate the winners and losers on top of each other and sort by season:
<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table style="font-size:75%" border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Seed</th>
      <th>OrdinalRank</th>
      <th>PIE</th>
      <th>eFGP</th>
      <th>ToR</th>
      <th>ORP</th>
      <th>FTR</th>
      <th>4Factor</th>
      <th>AdjO</th>
      <th>AdjD</th>
      <th>AdjEM</th>
      <th>DRP</th>
      <th>ORTM</th>
      <th>AR</th>
      <th>FTP</th>
      <th>PtsDf</th>
      <th>WinPCT</th>
      <th>result</th>
      <th>Season</th>
      <th>WTeamID</th>
      <th>LTeamID</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>-31</td>
      <td>-0.107021</td>
      <td>-0.013235</td>
      <td>0.012414</td>
      <td>-0.012949</td>
      <td>-0.152277</td>
      <td>-0.027622</td>
      <td>2.9</td>
      <td>4.8</td>
      <td>-1.90</td>
      <td>-0.056104</td>
      <td>-1.864368</td>
      <td>-0.008846</td>
      <td>0.152397</td>
      <td>-9.208046</td>
      <td>-0.151724</td>
      <td>1</td>
      <td>2003</td>
      <td>1421</td>
      <td>1411</td>
    </tr>
    <tr>
      <th>28</th>
      <td>11</td>
      <td>46</td>
      <td>-0.013858</td>
      <td>-0.014261</td>
      <td>0.011557</td>
      <td>-0.052423</td>
      <td>0.032148</td>
      <td>-0.008478</td>
      <td>-8.9</td>
      <td>4.3</td>
      <td>-13.24</td>
      <td>0.027260</td>
      <td>-3.586207</td>
      <td>-0.002358</td>
      <td>0.100614</td>
      <td>-1.793103</td>
      <td>-0.034483</td>
      <td>0</td>
      <td>2003</td>
      <td>1393</td>
      <td>1264</td>
    </tr>
    <tr>
      <th>27</th>
      <td>-1</td>
      <td>9</td>
      <td>0.082039</td>
      <td>0.067915</td>
      <td>0.003750</td>
      <td>0.025868</td>
      <td>-0.113316</td>
      <td>0.016280</td>
      <td>4.0</td>
      <td>3.2</td>
      <td>0.73</td>
      <td>-0.004268</td>
      <td>0.170507</td>
      <td>0.039910</td>
      <td>-0.103694</td>
      <td>3.822581</td>
      <td>0.034562</td>
      <td>0</td>
      <td>2003</td>
      <td>1345</td>
      <td>1261</td>
    </tr>
    <tr>
      <th>26</th>
      <td>13</td>
      <td>95</td>
      <td>-0.154728</td>
      <td>-0.025687</td>
      <td>-0.007815</td>
      <td>0.001559</td>
      <td>-0.096460</td>
      <td>-0.026386</td>
      <td>-10.1</td>
      <td>19.7</td>
      <td>-29.77</td>
      <td>-0.032008</td>
      <td>0.832258</td>
      <td>-0.018119</td>
      <td>0.083997</td>
      <td>-11.669892</td>
      <td>-0.189247</td>
      <td>0</td>
      <td>2003</td>
      <td>1338</td>
      <td>1447</td>
    </tr>
    <tr>
      <th>25</th>
      <td>5</td>
      <td>37</td>
      <td>0.032360</td>
      <td>0.069025</td>
      <td>-0.003349</td>
      <td>-0.055668</td>
      <td>-0.040919</td>
      <td>0.009501</td>
      <td>4.4</td>
      <td>8.7</td>
      <td>-4.32</td>
      <td>0.091727</td>
      <td>-1.390805</td>
      <td>0.037968</td>
      <td>0.036850</td>
      <td>4.260536</td>
      <td>0.125160</td>
      <td>0</td>
      <td>2003</td>
      <td>1329</td>
      <td>1335</td>
    </tr>
  </tbody>
</table>
</div>

What we end up with is a 21 by 1962 dataframe. The columns are the 17 features, the Result column, and three extra columns for Season, Winning Team ID, and Losing Team ID. Each row is a simulated "matchup" between tournament teams.

The second part covers the training, evaluation, and testing of the machine learning models, and the creation of submission file and more readible file that could be used to create an unbeatable bracket for your office pool.

The first step is separating the dataset into training and test data:
```python
y = prediction_dataset['result']
X = prediction_dataset.loc[:, :'WinPCT']
train_IDs = prediction_dataset.loc[:, 'Season':]

X_train, X_test, y_train, y_test = train_test_split(X, y, train_size=0.7, test_size=0.3, random_state=1, stratify=y)
```

I chose to go with with a 70/30 split of training to test data, which seemed to work considering the amount of data I had.

The next step is to initialize the six different classifiers:
  * [Logistic Regression](https://en.wikipedia.org/wiki/Logistic_regression)
  * [K Nearest Neighbors](https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm)
  * [XGBoost](https://en.wikipedia.org/wiki/Xgboost)
  * [Decision Tree](https://en.wikipedia.org/wiki/Decision_tree)
  * [Random Forest](https://en.wikipedia.org/wiki/Random_forest)
  * [Gradient Boosting](https://en.wikipedia.org/wiki/Gradient_boosting)

 and evaluate them using a [grid search cross validation](http://scikit-learn.org/stable/modules/generated/sklearn.model_selection.GridSearchCV.html). Without going into too much detail, the Logistic Regression classifier peformed the best, returning a test accuracy of 79.80%. I didn't realize this at the time, but it turns out I made a significant error in evaluating the classifiers. I used the training set in the grid search cross validation. What I should have done was have a validation set in addition to the training and test sets. (Not so much of an independent evaluation, is it?)

 Anyway, after fitting the model, I create a prediction dataset to simulate every possible match up of teams in the 2018 March Madness tournament:
 <div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>ID</th>
      <th>Pred</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2018_1104_1112</td>
      <td>0.438796</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2018_1104_1113</td>
      <td>0.352291</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2018_1104_1116</td>
      <td>0.338818</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2018_1104_1120</td>
      <td>0.362255</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2018_1104_1137</td>
      <td>0.719037</td>
    </tr>
  </tbody>
</table>
</div>

The three numbers in the ID column are the year of the tournament, the team #1, and team #2. The number in the Pred column is the probability that team #1 beats team #2. The format is required by Kaggle and doesn't really help if you want to create a bracket. 

The final piece of the code matches up the team IDs with team names and generates readable predictions, such as "Alabama beats Arizona: 0.563389". This doesn't necessarily guarantee that Alabama plays Arizona, but if they did there is 56% probability that Alabama wins.

So that's it, my first Kaggle competition. I have to admit I jumped into this knowing very little about supervised learning, Scikit-Learn, and classifier models, learning most of it on the fly. It was a good experience and I will definitely do it again next year. Maybe I will try different features and difference classifiers. Who knows, maybe I try some deep learning models. One thing I do know- I won't use training data on my cross validation!

Don't mind me, I'm just rambling.