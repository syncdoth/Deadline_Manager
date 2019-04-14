import pandas as pd
import datefinder
import dateparser
import datetime

df = pd.read_csv('/Users/Godwithus/Desktop/enron_05_17_2015_with_labels_v2_100K_chunk_1_of_6.csv', low_memory=False)

data = df[ df['labeled'] == True]



data = data[((data['Cat_1_level_1'] == 1) | (data['Cat_1_level_1'] == 2))] #1.1, 1.4, 1.5, 1.6, 3.12


# (data['Cat_1_level_1'] == 1) |
#( (data['Cat_1_level_2'] == '1') | (data['Cat_1_level_2'] == '4') | (data['Cat_1_level_2'] == '5') | (data['Cat_1_level_2'] == '6'))


data = data.loc[:,['Date','Subject','X-From', 'user', 'content', 'Cat_1_level_2']]

data.columns = ['Date','Subject','From','To','body','rawscore']

data['score'] = data['rawscore']

data.loc[(data['rawscore'] == 1), 'score'] = 'important'
data.loc[(data['rawscore'] == 2), 'score'] = 'not important'
data.loc[(data['rawscore'] == 3), 'score'] = 'not important'
data.loc[(data['rawscore'] == 4), 'score'] = 'not important'
data.loc[(data['rawscore'] == 5), 'score'] = 'important'
data.loc[(data['rawscore'] == 6), 'score'] = 'important'
data.loc[(data['rawscore'] == 7), 'score'] = 'not important'
data.loc[(data['rawscore'] == 8), 'score'] = 'not important'

"""score: 1 = unrelated 2 = not important 3 = somewhat important 4  = important 5 = very important
    1.1 = 3 
    1.2 = 2
    1.3 = 3
    1.4 = 5
    1.5 = 4
    1.6 = 4
    1.7 = 1
    1.8 = 1
"""

with pd.option_context('display.max_rows', None, 'display.max_columns', None):
    print(data)


# for i in range(5):
#     matches = datefinder.find_dates(data.iloc[i]['body'])
#
#     for match in matches:
#        print(match ,i)
#
# print(dateparser.parse(data.iloc[0]['body']))
# print(dateparser.parse(data.iloc[1]['body']))
# print(dateparser.parse(data.iloc[2]['body']))

data = data.loc[:, ['Date','Subject','From','To','body','score']]

data.to_csv('/Users/Godwithus/Downloads/mail_data1.csv')