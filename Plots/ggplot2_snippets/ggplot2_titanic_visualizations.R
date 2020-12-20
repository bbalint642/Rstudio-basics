#forras: Data Science Dojo, 2017.aug.18
# youtube link: https://www.youtube.com/watch?v=49fADBfcDD4


library(ggplot2)

titanic <- read.csv("titanic.csv", stringsAsFactors = FALSE)
View(titanic)


#set up factors ----
titanic$Pclass <- as.factor(titanic$Pclass)
titanic$Survived <- as.factor(titanic$Survived)
titanic$Sex <- as.factor(titanic$Sex)
titanic$Embarked <- as.factor(titanic$Embarked)

#titanic tulelok aranya ----
ggplot(titanic, aes(x = Survived)) +
  geom_bar()

#ha nagyon tudni akarjuk a százalékokat:
prop.table(table(titanic$Survived))

#alakitsuk kicsit a tengely cimeket, adjunk cimet a plotnak ----

ggplot(titanic, aes(x = Survived)) +
  theme_bw() +
  geom_bar() +
  labs(x="Tulelok", y="Utasok szama:", title = "Titanic tulelok aranya")


#masodik kerdes: a nemek szerint vizsgaljuk a tulelok aranyat ----
#szineket is hasznalunk
ggplot(titanic, aes(x = Sex, fill = Survived)) +
  theme_linedraw() + 
  geom_bar() +
  labs(x="Tulelok", y="Utasok szama:", title = "Titanic tulelok aranya")


#harmadik kerdes: fuggott-e a megvaltott jegy osztalyatol a tulelesi esely ----
ggplot(titanic, aes(x = Pclass, fill = Survived)) +
  theme_bw() + 
  geom_bar() +
  labs(x="Tulelok", y="Utasok szama:", title = "Titanic tulelok aranya a jegy-osztaly alapjan")


#negyedik kerdes: mi volt a tulelesi arany jegy-osztaly es nem alapjan? ----

ggplot(titanic, aes(x = Sex, fill = Survived)) +
  theme_bw() +
  facet_wrap(~ Pclass) +
  geom_bar() +
  labs(x="Tulelok", y="Utasok szama:", title = "Titanic tulelok aranya a jegy-osztaly es nem alapjan")


##otodik kerdes: Milyen az utasok eletkoranak megoszlasa? ----

ggplot(titanic, aes(x = Age)) +
  theme_bw() +
  geom_histogram(binwidth = 5) +
  labs(y = "Utasok szama",
       x = "Eletkor (binwidth = 5)",
       title = "Titanic: Eletkorok megoszlasa")

#hatodik kerdes: tuleles nem es kor szerint ----
ggplot(titanic, aes(x = Age, fill = Survived)) +
  theme_bw() +
  geom_histogram(binwidth = 5) +
  labs(y = "Utasok szama",
       x = "Eletkor (binwidth = 5)",
       title = "Titanic: Eletkorok megoszlasa")

#egy masik vizalizacios megközelites ugyan ehhez a kerdeshez a boxplot:

ggplot(titanic, aes(x = Survived, y = Age)) +
  theme_bw() +
  geom_boxplot() +
  labs(y = "Kor",
       x = "Tulelte",
       title = "Titanic: Tulelesi aranyok kor szerint")

#density plots:
ggplot(titanic, aes(x = Age, fill = Survived))+
  theme_bw() +
  facet_wrap(Sex ~ Pclass) +
  geom_density(alpha = 0.5) +
  labs( y = "Kor",
        x = "Tulelte",
        title = "Titanic: Tulelesi aranyok kor, jegy es nem szerint")

#bar plot:
ggplot(titanic, aes(x = Age, fill = Survived))+
  theme_bw() +
  facet_wrap(Sex ~ Pclass) +
  geom_histogram(binwidth = 5) +
  labs( y = "Kor",
        x = "Tulelte",
        title = "Titanic: Tulelesi aranyok kor, jegy es nem szerint")
