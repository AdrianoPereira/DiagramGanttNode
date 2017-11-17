CREATE TABLE IF NOT EXISTS `gantt_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `source` int(11) NOT NULL,
  `target` int(11) NOT NULL,
  `type` varchar(1) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `gantt_tasks` (
  `id` int(11) NOT NULL  AUTO_INCREMENT PRIMARY KEY,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `parent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*
DELIMITER $
CREATE TRIGGER tgr_teste AFTER INSERT
ON gantt_tasks
FOR EACH ROW
BEGIN
	INSERT INTO gatilho(nome) VALUES(gantt_tasks.text)
END$

DELIMITER ;


  CREATE TABLE `gantt_links` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `source` int(11) NOT NULL,
    `target` int(11) NOT NULL,
    `type` varchar(1) NOT NULL,
    PRIMARY KEY (`id`)
  );

CREATE TABLE `gantt_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  `start_date` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `progress` float NOT NULL,
  `sortorder` int(11) NOT NULL,
  `parent` int(11) NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `gantt_tasks1` VALUES ('1', 'Project #1', '2013-04-01 00:00:00', '5', '0.8', '20', '0');
INSERT INTO `gantt_tasks1` VALUES ('2', 'Task #1', '2013-04-06 00:00:00', '4', '0.5', '10', '1');
INSERT INTO `gantt_tasks1` VALUES ('3', 'Task #2', '2013-04-05 00:00:00', '6', '0.7', '20', '1');
INSERT INTO `gantt_tasks1` VALUES ('4', 'Task #3', '2013-04-07 00:00:00', '2', '0', '30', '1');
INSERT INTO `gantt_tasks1` VALUES ('5', 'Task #1.1', '2013-04-05 00:00:00', '5', '0.34', '10', '2');
INSERT INTO `gantt_tasks1` VALUES ('6', 'Task #1.2', '2013-04-11 13:22:17', '4', '0.491477', '20', '2');
INSERT INTO `gantt_tasks1` VALUES ('7', 'Task #2.1', '2013-04-07 00:00:00', '5', '0.2', '10', '3');
INSERT INTO `gantt_tasks1` VALUES ('8', 'Task #2.2', '2013-04-06 00:00:00', '4', '0.9', '20', '3');

INSERT INTO `gantt_tasks` 
  (text, start_date, duration, progress, sortorder, parent) 
  VALUES ('Task #2.2', '2013-04-06 00:00:00', '4', '0.9', '20', '3');

*/

-- SELECT CONCAT(
--   '[',
--     GROUP_CONCAT(
--       JSON_OBJECT(
--         'Nome', text, 
--         'Data', start_date
--       )
--     ), 
--   ']' 
-- ) 
-- FROM gantt_tasks;
-- /*JSON beutifier: https://jsonformatter.curiousconcept.com/*/

-- DELIMITER $
--   CREATE TRIGGER trg_ AFTER INSERT
--   ON quxmr_jem_events
--   FOR EACH ROW
--   BEGIN
-- 	  INSERT INTO gantt_tasks(text, start_date, duration, progress, parent) 
--       VALUES(quxmr_jem_events.title, quxmr_jem_events.dates, datediff(quxmr_jem_events.enddates, quxmr_jem_events.dates), )
--   END$
-- DELIMITER ;

-- SELECT title, datediff(quxmr_jem_events.enddates, quxmr_jem_events.dates) FROM 'quxmr_jem_events' WHERE id = 550;
/*

CREATE OR REPLACE VIEW gantt_tasks AS
(SELECT 	quxmr_jem_venues.venue as text, 
		min(quxmr_jem_events.dates) as start_date,
        datediff(max(quxmr_jem_events.enddates), min(quxmr_jem_events.dates)) as duration,
        (SELECT 5) as progress,
        (SELECT 0) as parent
        FROM 	quxmr_jem_events,
        		quxmr_jem_venues
        WHERE locid = 25 AND locid = quxmr_jem_venues.id
        GROUP BY text, progress, parent)
union

(SELECT 	quxmr_jem_events.title as text, 
		quxmr_jem_events.dates as start_date,
        datediff(quxmr_jem_events.enddates, quxmr_jem_events.dates) as duration,
        (SELECT 5) as progress,
        (SELECT 2) as parent
        FROM quxmr_jem_events
        WHERE locid = 25)
UNION

(SELECT 	quxmr_jem_events.custom2 as text, 
		min(quxmr_jem_events.dates) as start_date,
        datediff(max(quxmr_jem_events.enddates), min(quxmr_jem_events.dates)) as duration,
        (SELECT 0.4) as progress,
        (SELECT 1) as parent
        FROM quxmr_jem_events
        WHERE locid = 25
        GROUP BY text);
        
        
        
*/

/*
CREATE OR REPLACE VIEW gantt_tasks AS
(SELECT 	quxmr_jem_venues.id,
		quxmr_jem_venues.venue as text, 
		min(quxmr_jem_events.dates) as start_date,
        datediff(max(quxmr_jem_events.enddates), min(quxmr_jem_events.dates)) as duration,
        (SELECT 0.5) as progress,
        (SELECT 0) as parent
        FROM 	quxmr_jem_events,
        		quxmr_jem_venues
        WHERE locid = 25 AND locid = quxmr_jem_venues.id
        GROUP BY text, progress, parent)

UNION

(SELECT 	quxmr_jem_events.id,
		quxmr_jem_events.title as text, 
		quxmr_jem_events.dates as start_date,
        datediff(quxmr_jem_events.enddates, quxmr_jem_events.dates) as duration,
        (SELECT 0.5) as progress,
        (SELECT 2) as parent
        FROM quxmr_jem_events
        WHERE locid = 25)

UNION

(SELECT 	quxmr_jem_events.id,
		quxmr_jem_events.custom2 as text, 
		min(quxmr_jem_events.dates) as start_date,
        datediff(max(quxmr_jem_events.enddates), min(quxmr_jem_events.dates)) as duration,
        (SELECT 0.5) as progress,
        (SELECT 1) as parent
        FROM quxmr_jem_events
        WHERE locid = 25
        GROUP BY text, quxmr_jem_events.id);



*/

/*
DELIMITER $

CREATE TRIGGER gatilho AFTER INSERT ON quxmr_jem_events
FOR EACH ROW
BEGIN
	SELECT * from quxmr_jem_events
END$

DELIMITER ;
*/

/*
CREATE OR REPLACE VIEW gantt_tasks AS
(SELECT 	quxmr_jem_events.id,
		quxmr_jem_events.title as text, 
		quxmr_jem_events.dates as start_date,
        datediff(quxmr_jem_events.enddates, quxmr_jem_events.dates) as duration,
        (SELECT 0.5) as progress,
        (SELECT 2) as parent
        FROM quxmr_jem_events
        WHERE locid = 25)

UNION

(SELECT 	quxmr_jem_venues.id,
		quxmr_jem_venues.venue as text, 
		min(quxmr_jem_events.dates) as start_date,
        datediff(max(quxmr_jem_events.enddates), min(quxmr_jem_events.dates)) as duration,
        (SELECT 0.5) as progress,
        (SELECT 0) as parent
        FROM 	quxmr_jem_events,
        		quxmr_jem_venues
        WHERE locid = 25 AND locid = quxmr_jem_venues.id
        GROUP BY text, progress, parent)

UNION

(SELECT 	quxmr_jem_events.id,
		quxmr_jem_events.custom2 as text, 
		min(quxmr_jem_events.dates) as start_date,
        datediff(max(quxmr_jem_events.enddates), min(quxmr_jem_events.dates)) as duration,
        (SELECT 0.5) as progress,
        (SELECT ) as parent
        FROM quxmr_jem_events
        WHERE locid = 25
        GROUP BY text, quxmr_jem_events.id);

*/


/*>12
CREATE OR REPLACE VIEW gantt_tasks AS
(SELECT 	quxmr_jem_venues.id,
		quxmr_jem_venues.venue as text, 
		min(quxmr_jem_events.dates) as start_date,
        datediff(max(quxmr_jem_events.enddates), min(quxmr_jem_events.dates)) as duration,
        (SELECT 0.5) as progress,
        (SELECT 0) as parent
        FROM 	quxmr_jem_events,
        		quxmr_jem_venues
        WHERE locid = 25 AND locid = quxmr_jem_venues.id
        GROUP BY text, progress, parent)

UNION

(SELECT 	quxmr_jem_events.id,
		quxmr_jem_events.title as text, 
		quxmr_jem_events.dates as start_date,
        datediff(quxmr_jem_events.enddates, quxmr_jem_events.dates) as duration,
        (SELECT 0.5) as progress,
        (SELECT 1) as parent
        FROM quxmr_jem_events
        WHERE locid = 25)

UNION

(SELECT 	quxmr_jem_events.id,
		quxmr_jem_events.custom2 as text, 
		min(quxmr_jem_events.dates) as start_date,
        datediff(max(quxmr_jem_events.enddates), min(quxmr_jem_events.dates)) as duration,
        (SELECT 0.5) as progress,
        (SELECT 1) as parent
        FROM quxmr_jem_events
        WHERE locid = 25
        GROUP BY text, quxmr_jem_events.id);
*/