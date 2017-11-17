-- CREATE TABLE IF NOT EXISTS `gantt_tasks` (
--   `id` int(11) NOT NULL  AUTO_INCREMENT PRIMARY KEY,
--   `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
--   `start_date` datetime NOT NULL,
--   `duration` int(11) NOT NULL,
--   `parent` int(11) NOT NULL,
--   `atividade` int(11) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `gantt_tasks` (
  `id` int(11) NOT NULL  AUTO_INCREMENT PRIMARY KEY,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `progress` float NOT NULL DEFAULT 0,
  `parent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DELIMITER $

CREATE TRIGGER trg_insert_atividade AFTER INSERT ON quxmr_jem_events
FOR EACH ROW

BEGIN
	INSERT INTO gantt_tasks
        (text, 
        start_date, duration, 
        parent, atividade)
    VALUES 
        (NEW.title, NEW.dates, 
        datediff(NEW.enddates, NEW.dates), 
        0, NEW.id);
END $

DELIMITER ;


INSERT INTO `quxmr_jem_events` 
(`id`, `locid`, `dates`, `enddates`, 
`times`, `endtimes`, `title`, `alias`, 
`created_by`, `modified`, `modified_by`, 
`version`, `author_ip`, `created`, 
`introtext`, `meta_keywords`, `meta_description`, 
`recurrence_first_id`, `recurrence_number`, 
`recurrence_type`, `recurrence_counter`, 
`recurrence_limit`, `recurrence_limit_date`, 
`recurrence_byday`, `datimage`, `checked_out`, 
`checked_out_time`, `registra`, `unregistra`, 
`unregistra_until`, `maxplaces`, `waitinglist`, 
`hits`, `published`, `contactid`, `custom1`, 
`custom2`, `custom3`, `custom4`, `custom5`, 
`custom6`, `custom7`, `custom8`, `custom9`, 
`custom10`, `fulltext`, `created_by_alias`, 
`access`, `metadata`, `featured`, `attribs`, 
`language`) 
VALUES (NULL, '1', '2017-11-01', '2017-11-02', 
'03:09:13', '06:18:00', 'Atividade adicionada por gatilho', 
'1', '665', '2017-11-07 00:00:00', '665', '2', '', 
'2017-11-01 00:00:00', '', '', '', '0', '0', '0', 
'0', '0', NULL, NULL, '', '0', '2017-11-01 05:15:16', 
'0', '0', '0', '0', '0', '0', '0', '5', '', 'concepcao', '', '', 
'', '', '', '', '', '', '', '', '0', '', '0', '', '');

DELIMITER $

CREATE TRIGGER trg_update AFTER UPDATE ON quxmr_jem_events
FOR EACH ROW

BEGIN
	UPDATE gantt_tasks 
        SET text = NEW.title, 
        start_date = NEW.dates, 
        duration = datediff(NEW.enddates, NEW.dates), 
        parent = 1
    WHERE
        atividade = OLD.id;
END $

DELIMITER ;

SELECT min(dates), max(DATEDIFF(enddates, dates)) FROM `quxmr_jem_events`;

/*Funções*/
DELIMITER $
CREATE FUNCTION get_duracao_concepcao() RETURNS INT
BEGIN
DECLARE duracao INT;
   
    SELECT duracao = max(DATEDIFF(enddates, dates)) 
        FROM `quxmr_jem_events`;
    
    RETURN duracao;
END $
DELIMITER ;

/*INserção projeto*/
INSERT INTO gantt_tasks 
    (id, text, start_date, duration, progress, parent) 
    VALUES 
        (1, 'Solar', now(), 0, 0, 0);

/*Inserção das fases*/
INSERT INTO gantt_tasks 
    (id, text, start_date, duration, progress, parent) 
    VALUES 
        (2, 'Concepção', now(), 0, 1, 1);
INSERT INTO gantt_tasks 
    (id, text, start_date, duration, progress, parent) 
    VALUES 
        (3, 'Documentação', now(), 0, 1, 1);
INSERT INTO gantt_tasks 
    (id, text, start_date, duration, progress, parent) 
    VALUES 
        (4, 'Desenvolvimento', now(), 0, 1, 1);
INSERT INTO gantt_tasks 
    (id, text, start_date, duration, progress, parent) 
    VALUES 
        (5, 'Teste', now(), 0, 1, 1);
INSERT INTO gantt_tasks 
    (id, text, start_date, duration, progress, parent) 
    VALUES 
        (6, 'Homologação', now(), 0, 1, 1);
INSERT INTO gantt_tasks 
    (id, text, start_date, duration, progress, parent) 
    VALUES 
        (7, 'Implantação', now(), 0, 1, 1);
INSERT INTO gantt_tasks 
    (id, text, start_date, duration, progress, parent) 
    VALUES 
        (8, 'Treinamento', now(), 0, 1, 1);
INSERT INTO gantt_tasks 
    (id, text, start_date, duration, progress, parent) 
    VALUES 
        (9, 'Produção', now(), 0, 1, 1);


/*Nova versão do gatilho de insert*/
DELIMITER $

CREATE TRIGGER trg_insert_atividade AFTER INSERT ON quxmr_jem_events
FOR EACH ROW

BEGIN
	IF (NEW.custom2 = 'concepcao') THEN
        INSERT INTO gantt_tasks
            (text, 
            start_date, duration, 
            parent, atividade)
        VALUES 
            (NEW.title, NEW.dates, 
            datediff(NEW.enddates, NEW.dates), 
            2, NEW.id);
    END IF;

    IF (NEW.custom2 = 'documentacao') THEN
        INSERT INTO gantt_tasks
            (text, 
            start_date, duration, 
            parent, atividade)
        VALUES 
            (NEW.title, NEW.dates, 
            datediff(NEW.enddates, NEW.dates), 
            3, NEW.id);
    END IF;

    IF (NEW.custom2 = 'desenvolvimento') THEN
        INSERT INTO gantt_tasks
            (text, 
            start_date, duration, 
            parent, atividade)
        VALUES 
            (NEW.title, NEW.dates, 
            datediff(NEW.enddates, NEW.dates), 
            4, NEW.id);
    END IF;

    IF (NEW.custom2 = 'teste') THEN
        INSERT INTO gantt_tasks
            (text, 
            start_date, duration, 
            parent, atividade)
        VALUES 
            (NEW.title, NEW.dates, 
            datediff(NEW.enddates, NEW.dates), 
            5, NEW.id);
    END IF;

    IF (NEW.custom2 = 'homologacao') THEN
        INSERT INTO gantt_tasks
            (text, 
            start_date, duration, 
            parent, atividade)
        VALUES 
            (NEW.title, NEW.dates, 
            datediff(NEW.enddates, NEW.dates), 
            6, NEW.id);
    END IF;

    IF (NEW.custom2 = 'implantacao') THEN
        INSERT INTO gantt_tasks
            (text, 
            start_date, duration, 
            parent, atividade)
        VALUES 
            (NEW.title, NEW.dates, 
            datediff(NEW.enddates, NEW.dates), 
            7, NEW.id);
    END IF;

    IF (NEW.custom2 = 'treinamento') THEN
        INSERT INTO gantt_tasks
            (text, 
            start_date, duration, 
            parent, atividade)
        VALUES 
            (NEW.title, NEW.dates, 
            datediff(NEW.enddates, NEW.dates), 
            8, NEW.id);
    END IF;

    IF (NEW.custom2 = 'producao') THEN
        INSERT INTO gantt_tasks
            (text, 
            start_date, duration, 
            parent, atividade)
        VALUES 
            (NEW.title, NEW.dates, 
            datediff(NEW.enddates, NEW.dates), 
            9, NEW.id);
    END IF;
END $

DELIMITER ;