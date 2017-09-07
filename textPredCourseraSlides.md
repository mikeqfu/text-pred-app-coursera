A simple app for text prediction
========================================================
author: Qian Fu
date: 07 September 2017
font-family: Cambria
transition: rotate

Data Science - Capstone project

<small>
<small>
* Class starting from 7 March 2016
* URL to the app: https://mikeqfu.shinyapps.io/textPredCoursera
* R code available on: https://github.com/mikeqfu/textPredCoursera

</small>
</small>



Overview
========================================================
<small>
This slide deck is intended to 'decode' briefly how a simple word prediction application, "<a href="https://mikeqfu.shinyapps.io/textPredCoursera" target="_blank">textPredCoursera</a>", works. The app was: 

- created for the <a href="https://www.coursera.org/learn/data-science-project" target="_blank">Capstone Project</a> of 
<a href="https://www.coursera.org/specializations/jhu-data-science" target="_blank">Data Science</a> course, which is a 10-course series on Coursera; 
- used for predicting a likely word following a given text message, 
in which case a few alternatives are available; 
    - <small>For example, when we type: "*It was nice*", the app would suggest that the next word is very likely to be "*to*" or something like "*meeting*", "*seeing*", etc. **(This example is demonstrated at the startup of the app)**.</small>
- based on <a href="https://en.wikipedia.org/wiki/N-gram" target="_blank">*N*-gram</a> frequencies from written text data sourced from Internet blogs, news and twitter. 

<small>The raw data set is available here: <a href="https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip" target="_blank">Coursera-SwiftKey.zip</a>.</small>
</small>



Data preparation
========================================================
<small><small>
All the original written text data (including blogs, news and tweets) was mixed together; and 67.5% of the merged data set was selected randomly as a training set for the development of the text prediction model. 

**Due to the large size of the training set, it was split into a number of smaller data sets, each of which was processed separately via the same via statistical natural language processing method**:

- Creating and cleaning 
<a href="https://en.wikipedia.org/wiki/Text_corpus" target="_blank">text corpora</a> 
for each sub-sample. See also **`create.corpus()`** in 
<a href="https://github.com/mikeqfu/textPredCoursera/blob/master/Code.Rmd" target="_blank">Code</a>;
- <a href="https://en.wikipedia.org/wiki/Tokenization_(lexical_analysis)" target="_blank">Tokenizing</a> the corpora and building frequency tables of ***2*-grams**, ***3*-grams**, ***4*-grams** and ***5*-grams** based on the processed corpora. See also **`create.n.gram()`** in 
<a href="https://github.com/mikeqfu/textPredCoursera/blob/master/Code.Rmd" target="_blank">Code</a>;
    - Combining frequency tables for each of the ***N*-grams**, respectively; and sort each table in the descending order of the frequency;
    
- For each ***N*-gram** table, split the n-gram column into two columns, with one containing the last word and the other containing the rest. *(An example table is shown on next slide.)*

</small></small>



Word prediction
========================================================
<small><small><small>
With the processed *N*-grams frequency data, we could simply make a prediction of a word that would be likely to come next to e.g. an input word/phrase. The algorithm implemented in the app is briefly described by drawing support from the default example as follows: 

- As we input "It was nice to", the word count is greater than or equal to **4**, the app will firstly try to search through the ***5*-gram** table and locate a few "`asInput`" records that matches the **last 4 words** of the input (as can be seen below). The app will then treat the word in "`nextWord`" column with the highest "`Frequency`" as the first prediction. 

`asInput`        | `nextWord`  | `Frequency`
---------------- | ----------- | ---------
"It was nice to" | **"see"**   | **60**
"It was nice to" | "meet"      | 33
"It was nice to" | "have"      | 30
...              | ...         | ...

- If the word count of the input equals **3**, the search will start from the ***4*-gram** table, and so forth.
- However, if none of the "`asInput`" in the ***N*-gram** table matches the input text, the app will then try to search in the **(*N*-1)-gram** table, and so on until the ***2*-gram** table has been examined.
- If a matched record is still NOT found, a possible reason might be that the input is not English or contains incorrectly-spelled words. In that case, no prediction will be returned. 

See also function **`predictNextWord()`** in <a href="https://github.com/mikeqfu/textPredCoursera/blob/master/Code.Rmd" target="_blank">Code</a>.
</small></small></small>



Brief summary of the app
========================================================
- <small>The app introduced in this slide deck can predict the next word as we type in the textbox on the main panel, and provide several alternatives for what the next word might be: <small>
    - the most-likely next word will show/update below "**The next word might be**";
    - more alternative words will also be available below "**More alternatives of the next word**";
    - clicking "**Show/Update ...**" button will present a reference histogram for the current prediction; and 
    - clicking "**Hide/Display**" button hides or displays the current histogram again.

    *(A full set of instructions of how to use the app is available on the left-hand sidebar of the app)*
</small>
- There is still a lot of room for improvement on both accuracy and efficiency of the prediction algorithm, which will need to be evaluated with the test data set.

</small>
