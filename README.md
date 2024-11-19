# Olympics Data Analysis

This project involves analyzing historical data from the Olympic Games to uncover various insights, such as the number of games held, participating nations, top-performing athletes and countries, and much more.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Dataset Description](#dataset-description)
3. [Analysis Questions](#analysis-questions)
4.  [Analysis SQL Queries](#analysis-SQL-questions)
5. [Setup and Installation](#setup-and-installation)
6. [Usage](#usage)
7. [Results](#results)
8. [Contributing](#contributing)
9. [License](#license)

## Project Overview

The goal of this project is to analyze data from past Olympic Games to answer key questions about participation, performance, and trends. This analysis is conducted using SQL queries to extract valuable insights from the dataset.

## Dataset Description

The dataset used in this project contains information on the following:

- **Olympic Games**: Year, Season (Summer/Winter), City, and Country.
- **Athletes**: Name, Gender, Age, Country, Sport, and Event.
- **Medals**: Type (Gold, Silver, Bronze), Athlete, Country, Sport, and Event.
- **Participating Nations**: List of countries that participated in each Olympic Games.

The dataset is assumed to be stored in a **relational database** with the following tables:

- `olympic_games`
- `athletes`
- `medals`
- `events`

## Analysis Questions

The following are the key questions addressed in this project:

1. How many Olympic Games have been held?
2. List all Olympic Games held so far.
3. Total number of nations that participated in each Olympic Game.
4. Which year saw the highest and lowest number of countries participating in the Olympics?
5. Which nation has participated in all of the Olympic Games?
6. Identify the sport that was played in all Summer Olympics.
7. Which sports were played only once in the Olympics?
8. Fetch the total number of sports played in each Olympic Game.
9. Fetch details of the oldest athlete to win a gold medal.
10. Find the ratio of male to female athletes who participated in all Olympic Games.
11. Fetch the top 5 athletes who have won the most gold medals.
12. Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
13. Fetch the top 5 most successful countries in the Olympics. Success is defined by the number of medals won.
14. List total gold, silver, and bronze medals won by each country.
15. List total gold, silver, and bronze medals won by each country corresponding to each Olympic Game.
16. Identify which country won the most gold, most silver, and most bronze medals in each Olympic Game.
17. Identify which country won the most gold, most silver, most bronze medals, and the most medals in each Olympic Game.
18. Which countries have never won a gold medal but have won silver/bronze medals?
19. In which sport/event has India won the most medals?
20. Break down all Olympic Games where India won a medal for Hockey and how many medals in each Olympic Ga)


## SQL Queries
![ Queries](https://github.com/Boluyimika/-olympics-data-analysis/blob/main/Query-1.sql)

## Visualization
![Dashboard](https://github.com/Boluyimika/-olympics-data-analysis/blob/main/Olympic_data%20visualization.png?raw=true)
![]()

## Setup and Installation

To run the analysis, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Boluyimika/olympics-data-analysis.git
   cd olympics-data-analysis
## Contribution
Contributions are welcome! If you have any suggestions or improvements, please submit a pull request or open an issue.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

