CREATE TABLE `gantt_tasks_new` (
  `text` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `duration` int(11) NOT NULL,
  `progress` float NOT NULL,
  `parent` int(11) NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `gantt_tasks_new` VALUES ('1', 'Project #1', '2013-04-01', '5', '0.8', '20', '0');
INSERT INTO `gantt_tasks_new` VALUES ('2', 'Task #1', '2013-04-06', '4', '0.5', '10', '1');
INSERT INTO `gantt_tasks_new` VALUES ('3', 'Task #2', '2013-04-05', '6', '0.7', '20', '1');
INSERT INTO `gantt_tasks_new` VALUES ('4', 'Task #3', '2013-04-07', '2', '0', '30', '1');
INSERT INTO `gantt_tasks_new` VALUES ('5', 'Task #1.1', '2013-04-05', '5', '0.34', '10', '2');
INSERT INTO `gantt_tasks_new` VALUES ('6', 'Task #1.2', '2013-04-11', '4', '0.491477', '20', '2');
INSERT INTO `gantt_tasks_new` VALUES ('7', 'Task #2.1', '2013-04-07', '5', '0.2', '10', '3');
INSERT INTO `gantt_tasks_new` VALUES ('8', 'Task #2.2', '2013-04-06', '4', '0.9', '20', '3');

CREATE OR REPLACE VIEW gantt_tasks AS
(SELECT quxmr_jem_events.id as id,
        quxmr_jem_venues.venue as text, 
		min(quxmr_jem_events.dates) as start_date,
        datediff(max(quxmr_jem_events.enddates), min(quxmr_jem_events.dates)) as duration,
        (SELECT 5) as progress,
        (SELECT 0) as parent
        FROM 	quxmr_jem_events,
        		quxmr_jem_venues
        WHERE locid = 25 AND locid = quxmr_jem_venues.id
        GROUP BY text, progress, parent)
union

(SELECT quxmr_jem_events.id as id, 	
        quxmr_jem_events.title as text, 
		quxmr_jem_events.dates as start_date,
        datediff(quxmr_jem_events.enddates, quxmr_jem_events.dates) as duration,
        (SELECT 5) as progress,
        (SELECT 2) as parent
        FROM quxmr_jem_events
        WHERE locid = 25)
UNION

(SELECT quxmr_jem_events.id as id, ,
        quxmr_jem_events.custom2 as text, 
		min(quxmr_jem_events.dates) as start_date,
        datediff(max(quxmr_jem_events.enddates), min(quxmr_jem_events.dates)) as duration,
        (SELECT 5) as progress,
        (SELECT 1) as parent
        FROM quxmr_jem_events
        WHERE locid = 25
        GROUP BY text);