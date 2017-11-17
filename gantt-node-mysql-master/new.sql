CREATE OR REPLACE table gantt_tasks AS
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

(SELECT quxmr_jem_events.id,
		quxmr_jem_events.title as text, 
		quxmr_jem_events.dates as start_date,
        datediff(quxmr_jem_events.enddates, quxmr_jem_events.dates) as duration,
        (SELECT 0.5) as progress,
        (SELECT 1) as parent
        FROM quxmr_jem_events
        WHERE locid = 25 and datediff(quxmr_jem_events.enddates, quxmr_jem_events.dates) <> '')


    
CREATE TABLE IF NOT EXISTS `auxiliar` (
  `id` int(11) NOT NULL  AUTO_INCREMENT PRIMARY KEY,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `parent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELIMITER $

CREATE TRIGGER gatilho AFTER INSERT ON alterada
FOR EACH ROW

BEGIN
	INSERT INTO auxiliar(text, start_date, duration, parent)
    VALUES (NEW.valor, now(), 5, 0);
END $

DELIMITER ;

/*Modificações*/
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL  AUTO_INCREMENT PRIMARY KEY,
  `nome` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `log` (
  `id` int(11) NOT NULL  AUTO_INCREMENT PRIMARY KEY,
  `user` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO user (nome) VALUES('Hello');

DELIMITER $

CREATE TRIGGER g1 AFTER INSERT ON user
FOR EACH ROW

BEGIN
	INSERT INTO log(usuario, id_user)
    VALUES (NEW.nome);
END $

DELIMITER ;

DELIMITER $

CREATE TRIGGER g2 AFTER UPDATE ON user
FOR EACH ROW

BEGIN
	UPDATE log SET usuario = new.nome WHERE id_user = old.id;
END $

DELIMITER ;

