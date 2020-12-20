# forrasok ehhez a filehoz elerhetoek youtubeon, a kovetkezo linken:
# https://www.youtube.com/watch?v=jWjqLW-u3hc&t=901s
# video neve: Hands-on dplyr tutorial for faster data manipulation in R
# feltolto: Data School, 2014.aug.23.

library(dplyr)
library(hflights)

##explore data ----
data(hflights)
head(hflights)

# as_tibble local data framet hoz letre

# atalakitas local data framenek
flights <- as_tibble(hflights)

# print csak 10 sort mutat es annyi oszlopot amennyi kifer a kepernyore
flights

# megadhatunk tobb vagy kevesebb sort n = ??
print(flights, n=20)

# normal data frame
data.frame(head(flights))


## Filter(): megtartjuk a kriteriumoknak megfelelo sorokat ----

#base R megkozelites:
flights[flights$Month==1 & flights$DayofMonth==1, ]

#dplyr megkozelites:
# hasznalhatunk vesszot vagy "&"-jelet az ES (AND) allitashoz
filter(flights, Month==1, DayofMonth==1)

# hasznalhatunk |-t VAGY (OR) allitasokhoz
filter(flights, UniqueCarrier=="AA" | UniqueCarrier=="UA")

# hasznalhatunk %in% operatort
filter(flights, UniqueCarrier %in% c("AA", "UA"))

## Select(): oszlopok kivalasztasa nev szerint ----

# base r megkozelites: 
flights[, c("DepTime", "ArrTime", "FlightNum")]

# dplyr megkozelites: 
select(flights, DepTime, ArrTime, FlightNum)

select(flights, Year:Month, contains("Num"), contains("Time"))


## Chaining vagy Pipelining ----

# nesting eljarasok
filter(select(flights, UniqueCarrier, DepDelay), DepDelay > 60)

# pipe hasznalata
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  filter(DepDelay > 60)

## Arrange(): sorok ujra rendezese ----

#base r megoldas: 
flights[order(flights$DepDelay), c("UniqueCarrier", "DepDelay")]

#dplyr megoldas:
#novekvo sorrend
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(DepDelay)

# desc vagy arrange(-DepDelay) csokkeno sorrendhez
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(desc(DepDelay))




## Mutate(): uj valtozok hozzaadasa ----

#base r: 
flights$Speed <- flights$Distance / flights$AirTime*60
flights[, c("Distance", "AirTime", "Speed")]

#dpyr + pipe
flights %>% 
  select(Distance, AirTime) %>%
  mutate(Speed = Distance / AirTime*60)

# uj valtozo tarolasa:
flights <- flights %>% mutate(Speed = Distance / AirTime*60)


## Summarise(): osszegzesek/csoportositasok ----

#base r:
head(with(flights, tapply(ArrDelay, Dest, mean, na.rm = TRUE)))
head(aggregate(ArrDelay ~ Dest, flights, mean))


#dplyr + pipe:
flights %>%
  group_by(Dest) %>%
  summarise(avg_delay = mean(ArrDelay, na.rm = TRUE))


# Summarise_each(): tobb oszlop osszefoglalasa egyszerre
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(mean, Cancelled, Diverted)


# minimum es maximum kesesek kiszamitasa legitarsasagok szerint
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(min(., na.rm=TRUE), max(., na.rm = TRUE)),
    matches("Delay"))


# az ev minden napjara megszamoljuk, hogy aznap hany jarat volt osszesen, es ezt csokkeno sorrendbe rendezzuk
flights %>%
  group_by(Month, DayofMonth) %>%
  summarise(flight_count = n()) %>%
  arrange(desc(flight_count))
  
  
