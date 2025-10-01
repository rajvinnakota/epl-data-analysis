-- 1. League Table: Season-wise total points
SELECT	Season, Team,
		SUM(PTS_Source) AS TotalPoints,
        SUM(GF_Source) AS GoalsFor,
        SUM(GA_Source) AS GoalsAgainst
FROM	Team_Centric
GROUP BY Season, Team
ORDER BY Season, TotalPoints DESC;

-- 2. Home vs Away Performance
SELECT Team, HA,
       COUNT(*) AS Matches,
       SUM(CASE WHEN RES='W' THEN 1 ELSE 0 END) AS Wins,
       SUM(CASE WHEN RES='D' THEN 1 ELSE 0 END) AS Draws,
       SUM(CASE WHEN RES='L' THEN 1 ELSE 0 END) AS Losses,
       SUM(PTS_Source) AS TotalPoints
FROM Team_Centric
GROUP BY Team, HA
ORDER BY Team, HA;

-- 3. Seasonal Trends
SELECT	Season,Team,
		SUM(PTS_Source) AS TotalPoints,
		SUM(GF_Source) AS GoalsFor,
		SUM(GA_Source) AS GoalsAgainst,
		SUM(GD_Source) AS GoalDifference
FROM	Team_Centric
GROUP BY Season, Team
ORDER BY Season, Team;

-- 4. Win % per Team
SELECT Team,
       ROUND(SUM(CASE WHEN RES = 'W' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS Win_Percentage
FROM team_centric
GROUP BY Team
ORDER BY Win_Percentage DESC;

-- 5. Performance vs Big 6 (Arsenal, Chelsea, Liverpool, Man City, Man United, Tottenham)
SELECT
    Team1,
    Team2,
    COUNT(*) AS Matches_Played,
    SUM(CASE WHEN Team1_GF > Team2_GF THEN 1 ELSE 0 END) AS Team1_Wins,
    SUM(CASE WHEN Team2_GF > Team1_GF THEN 1 ELSE 0 END) AS Team2_Wins,
    SUM(CASE WHEN Team1_GF = Team2_GF THEN 1 ELSE 0 END) AS Draws
FROM (
    SELECT 
        LEAST(Team, Opponent) AS Team1,
        GREATEST(Team, Opponent) AS Team2,
        MAX(CASE WHEN Team = LEAST(Team, Opponent) THEN GF_Source ELSE GA_Source END) AS Team1_GF,
        MAX(CASE WHEN Team = GREATEST(Team, Opponent) THEN GF_Source ELSE GA_Source END) AS Team2_GF
    FROM team_centric
    WHERE Team IN ('Arsenal','Chelsea','Liverpool','Man City','Man United','Tottenham')
      AND Opponent IN ('Arsenal','Chelsea','Liverpool','Man City','Man United','Tottenham')
    GROUP BY LEAST(Team, Opponent), GREATEST(Team, Opponent), Date
) AS match_level
GROUP BY Team1, Team2
ORDER BY Matches_Played DESC;

-- 6. Highest Scoring Games
SELECT Season, Date, 
       LEAST(Team, Opponent) AS Team1,
       GREATEST(Team, Opponent) AS Team2,
       MAX(GF_source + GA_source) AS Total_Goals
FROM team_centric
GROUP BY Season, Date, 
         LEAST(Team, Opponent), 
         GREATEST(Team, Opponent)
ORDER BY Total_Goals DESC
LIMIT 10;




