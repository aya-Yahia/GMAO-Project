USE gmao_camions;

-- Clear previous test data to prevent Duplicate Key errors
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Fact_Consommation;
TRUNCATE TABLE Fact_BT;
TRUNCATE TABLE Fact_IP;
TRUNCATE TABLE Fact_DI;
TRUNCATE TABLE Dim_Pieces;
TRUNCATE TABLE Dim_Equipements;
SET FOREIGN_KEY_CHECKS = 1;

-- ==========================================
-- 1. DIMENSION TABLES: MASTER REGISTRIES
-- ==========================================
INSERT INTO Dim_Equipements (code_equipement, designation, famille) VALUES 
('EQ-TRK01-MOT', 'Moteur Diesel Cummins 15L', 'Moteur'),
('EQ-TRK01-FRN', 'Système de Freinage Pneumatique', 'Sécurité/Freins'),
('EQ-TRK01-SUS', 'Amortisseurs Avant G/D', 'Châssis'),
('EQ-TRK02-TRN', 'Boîte de Vitesse Automatique', 'Transmission'),
('EQ-TRK02-HYD', 'Pompe Hydraulique Principale', 'Hydraulique'),
('EQ-TRK02-PNE', 'Train de Pneus Arrière', 'Pneumatique'),
('EQ-TRK03-MOT', 'Moteur Diesel Volvo D13', 'Moteur'),
('EQ-TRK03-ELC', 'Alternateur et Circuit Électrique', 'Électricité'),
('EQ-TRK04-CHX', 'Suspension et Châssis Heavy-Duty', 'Châssis'),
('EQ-TRK05-MOT', 'Moteur Scania V8 DC16', 'Moteur');

INSERT INTO Dim_Pieces (code_piece, designation, utilisation, famille_piece, sous_famille_piece, lieu_stockage, reference_constructeur, quantite_en_stock) VALUES 
('P-FLT-88', 'Filtre à carburant', 'Filtration système injection', 'Moteur', 'Filtres', 'Zone A-Rack 2', 'CUMMINS-88F', 40),
('P-BRK-12', 'Plaquette de frein heavy-duty', 'Remplacement plaquettes usées', 'Châssis', 'Freins', 'Zone B-Rack 1', 'BENDIX-B12', 14),
('P-OIL-05', 'Huile Moteur Synthétique 15W40 (1L)', 'Lubrification moteur', 'Moteur', 'Lubrifiants', 'Zone C-Cuve 1', 'SHELL-R4', 120),
('P-HYD-22', 'Joint torique hydraulique', 'Étanchéité circuit haute pression', 'Hydraulique', 'Joints', 'Zone A-Tiroir 4', 'VALVO-J22', 4),
('P-ELC-09', 'Fusible automobile 20A', 'Protection circuits électriques', 'Électricité', 'Composants', 'Zone D-Boîte 1', 'BUSS-F20', 200),
('P-FLT-90', 'Filtre à air moteur', 'Filtration air admission', 'Moteur', 'Filtres', 'Zone A-Rack 3', 'VOLVO-90A', 3),
('P-PNE-45', 'Pneu Michelin X Works 315/80', 'Remplacement pneu usé train roulant', 'Pneumatique', 'Pneus', 'Zone Extérieure', 'MICH-315', 12),
('P-SUS-11', 'Kit Amortisseur Pneumatique', 'Suspension cabine et châssis', 'Châssis', 'Suspension', 'Zone B-Rack 3', 'MONROE-S11', 2);

-- ==========================================
-- 2. FACT_DI: 50 ROWS (DEMANDES D'INTERVENTION)
-- ==========================================
INSERT INTO Fact_DI (numero_di, titre, etat_di, degre_urgence, famille_di, etat_du_camion, demandeur, code_equipement) VALUES 
('DI-2026-001', 'Perte de puissance moteur', 'Soldée', 'Critique', 'Mécanique', 'Non disponible', 'Chauffeur Ahmed', 'EQ-TRK01-MOT'),
('DI-2026-002', 'Bruit suspect freins avant', 'Soldée', 'Moyen', 'Sécurité', 'Disponible', 'Chauffeur Yassine', 'EQ-TRK01-FRN'),
('DI-2026-003', 'Fuite hydraulique vérin', 'À traiter', 'Élevé', 'Hydraulique', 'En charge', 'Mécanicien Sami', 'EQ-TRK02-HYD'),
('DI-2026-004', 'Témoin batterie tableau', 'À traiter', 'Faible', 'Électricité', 'Disponible', 'Chauffeur Khaled', 'EQ-TRK03-ELC'),
('DI-2026-005', 'Fissure support châssis', 'Annulée', 'Faible', 'Structure', 'Disponible', 'Contrôleur Mourad', 'EQ-TRK04-CHX'),
('DI-2026-006', 'Surchauffe moteur en charge', 'En cours', 'Critique', 'Mécanique', 'Non disponible', 'Chauffeur Ahmed', 'EQ-TRK01-MOT'),
('DI-2026-007', 'Chute pression air freins', 'À traiter', 'Élevé', 'Sécurité', 'Non disponible', 'Chauffeur Yassine', 'EQ-TRK01-FRN'),
('DI-2026-008', 'Craquement boîte de vitesse', 'À traiter', 'Moyen', 'Transmission', 'Disponible', 'Chauffeur Riadh', 'EQ-TRK02-TRN'),
('DI-2026-009', 'Crevaison pneu arrière droit', 'Soldée', 'Élevé', 'Pneumatique', 'Non disponible', 'Chauffeur Khaled', 'EQ-TRK02-PNE'),
('DI-2026-010', 'Clignotant gauche HS', 'Soldée', 'Faible', 'Électricité', 'Disponible', 'Chauffeur Ali', 'EQ-TRK03-ELC'),
('DI-2026-011', 'Vibrations cabine importantes', 'À traiter', 'Moyen', 'Châssis', 'Disponible', 'Chauffeur Ahmed', 'EQ-TRK01-SUS'),
('DI-2026-012', 'Consommation huile excessive', 'En cours', 'Élevé', 'Mécanique', 'Disponible', 'Mécanicien Sami', 'EQ-TRK05-MOT'),
('DI-2026-013', 'Jeu dans le bras suspension', 'À traiter', 'Élevé', 'Châssis', 'Non disponible', 'Contrôleur Mourad', 'EQ-TRK04-CHX'),
('DI-2026-014', 'Manque réactivité pédale frein', 'En cours', 'Critique', 'Sécurité', 'Non disponible', 'Chauffeur Yassine', 'EQ-TRK01-FRN'),
('DI-2026-015', 'Baisse pression hydraulique', 'À traiter', 'Élevé', 'Hydraulique', 'En charge', 'Chauffeur Riadh', 'EQ-TRK02-HYD'),
('DI-2026-016', 'Fumée blanche à l''échappement', 'À traiter', 'Élevé', 'Mécanique', 'Non disponible', 'Chauffeur Ahmed', 'EQ-TRK01-MOT'),
('DI-2026-017', 'Usure irrégulière pneu avant', 'À traiter', 'Moyen', 'Pneumatique', 'Disponible', 'Chauffeur Khaled', 'EQ-TRK02-PNE'),
('DI-2026-018', 'Jauge carburant instable', 'À traiter', 'Faible', 'Électricité', 'Disponible', 'Chauffeur Ali', 'EQ-TRK03-ELC'),
('DI-2026-019', 'Rapport de vitesse bloqué', 'À traiter', 'Critique', 'Transmission', 'Non disponible', 'Chauffeur Riadh', 'EQ-TRK02-TRN'),
('DI-2026-020', 'Fuite huile carter moteur', 'À traiter', 'Moyen', 'Mécanique', 'Disponible', 'Mécanicien Sami', 'EQ-TRK05-MOT'),
('DI-2026-021', 'Bruit métallique sous châssis', 'À traiter', 'Moyen', 'Châssis', 'Disponible', 'Contrôleur Mourad', 'EQ-TRK04-CHX'),
('DI-2026-022', 'Essuie-glace en panne', 'Soldée', 'Faible', 'Électricité', 'Disponible', 'Chauffeur Ahmed', 'EQ-TRK03-ELC'),
('DI-2026-023', 'Sifflement turbo compresseur', 'En cours', 'Élevé', 'Mécanique', 'En charge', 'Chauffeur Yassine', 'EQ-TRK03-MOT'),
('DI-2026-024', 'Échauffement tambour de frein', 'À traiter', 'Élevé', 'Sécurité', 'Non disponible', 'Chauffeur Riadh', 'EQ-TRK01-FRN'),
('DI-2026-025', 'Flexible hydraulique craquelé', 'À traiter', 'Moyen', 'Hydraulique', 'Disponible', 'Mécanicien Sami', 'EQ-TRK02-HYD'),
('DI-2026-026', 'Climatisation en panne cabine', 'À traiter', 'Faible', 'Confort', 'Disponible', 'Chauffeur Khaled', 'EQ-TRK03-ELC'),
('DI-2026-027', 'Ratés d''allumage à froid', 'À traiter', 'Moyen', 'Mécanique', 'Disponible', 'Chauffeur Ahmed', 'EQ-TRK01-MOT'),
('DI-2026-028', 'Déséquilibre freinage arrière', 'À traiter', 'Élevé', 'Sécurité', 'Non disponible', 'Chauffeur Yassine', 'EQ-TRK01-FRN'),
('DI-2026-029', 'Fuite liquide de refroidissement', 'Soldée', 'Élevé', 'Mécanique', 'Non disponible', 'Chauffeur Riadh', 'EQ-TRK03-MOT'),
('DI-2026-030', 'Projecteur principal grillé', 'Soldée', 'Faible', 'Électricité', 'Disponible', 'Chauffeur Ali', 'EQ-TRK03-ELC'),
('DI-2026-031', 'Amortisseur qui fuit', 'À traiter', 'Moyen', 'Châssis', 'Disponible', 'Contrôleur Mourad', 'EQ-TRK01-SUS'),
('DI-2026-032', 'Odomètre bloqué au tableau', 'À traiter', 'Faible', 'Électricité', 'Disponible', 'Chauffeur Khaled', 'EQ-TRK03-ELC'),
('DI-2026-033', 'Vibration levier de vitesse', 'À traiter', 'Moyen', 'Transmission', 'Disponible', 'Chauffeur Riadh', 'EQ-TRK02-TRN'),
('DI-2026-034', 'Ralenti moteur instable', 'À traiter', 'Moyen', 'Mécanique', 'Disponible', 'Chauffeur Ahmed', 'EQ-TRK05-MOT'),
('DI-2026-035', 'Manque de graisse sellette', 'Soldée', 'Faible', 'Châssis', 'Disponible', 'Mécanicien Sami', 'EQ-TRK04-CHX'),
('DI-2026-036', 'Dureté direction assistée', 'En cours', 'Élevé', 'Hydraulique', 'En charge', 'Chauffeur Yassine', 'EQ-TRK02-HYD'),
('DI-2026-037', 'Alarme ABS allumée', 'À traiter', 'Élevé', 'Sécurité', 'Disponible', 'Chauffeur Khaled', 'EQ-TRK01-FRN'),
('DI-2026-038', 'Corrosion perforante garde-boue', 'À traiter', 'Faible', 'Structure', 'Disponible', 'Contrôleur Mourad', 'EQ-TRK04-CHX'),
('DI-2026-039', 'Pneu lisse limite témoin', 'À traiter', 'Moyen', 'Pneumatique', 'Disponible', 'Chauffeur Ali', 'EQ-TRK02-PNE'),
('DI-2026-040', 'Coupure moteur intempestive', 'À traiter', 'Critique', 'Mécanique', 'Non disponible', 'Chauffeur Ahmed', 'EQ-TRK01-MOT'),
('DI-2026-041', 'Bruit roulement roue avant', 'À traiter', 'Moyen', 'Châssis', 'Disponible', 'Chauffeur Yassine', 'EQ-TRK01-SUS'),
('DI-2026-042', 'Voyant préchauffage clignote', 'À traiter', 'Moyen', 'Électricité', 'Disponible', 'Chauffeur Riadh', 'EQ-TRK03-ELC'),
('DI-2026-043', 'Suintement raccord hydraulique', 'Soldée', 'Faible', 'Hydraulique', 'Disponible', 'Mécanicien Sami', 'EQ-TRK02-HYD'),
('DI-2026-044', 'Perte de liquide lave-glace', 'Soldée', 'Faible', 'Accessoire', 'Disponible', 'Chauffeur Khaled', 'EQ-TRK03-ELC'),
('DI-2026-045', 'Difficulté de démarrage à chaud', 'À traiter', 'Moyen', 'Mécanique', 'Disponible', 'Chauffeur Ahmed', 'EQ-TRK03-MOT'),
('DI-2026-046', 'Verrouillage cabine défectueux', 'À traiter', 'Moyen', 'Sécurité', 'Disponible', 'Contrôleur Mourad', 'EQ-TRK04-CHX'),
('DI-2026-047', 'Sifflement plaquettes arrières', 'À traiter', 'Faible', 'Sécurité', 'Disponible', 'Chauffeur Yassine', 'EQ-TRK01-FRN'),
('DI-2026-048', 'Niveau huile boîte bas', 'À traiter', 'Moyen', 'Transmission', 'Disponible', 'Mécanicien Sami', 'EQ-TRK02-TRN'),
('DI-2026-049', 'Éclatement pneu sur piste', 'Soldée', 'Élevé', 'Pneumatique', 'Non disponible', 'Chauffeur Riadh', 'EQ-TRK02-PNE'),
('DI-2026-050', 'Perte d''écrou de roue suspectée', 'À traiter', 'Critique', 'Sécurité', 'Non disponible', 'Contrôleur Mourad', 'EQ-TRK04-CHX');

-- ==========================================
-- 3. FACT_IP: 50 ROWS (INTERVENTIONS PLANIFIÉES)
-- ==========================================
INSERT INTO Fact_IP (numero_ip, titre, declencheur, type_work, code_equipement) VALUES 
('IP-2026-001', 'Contrôle mensuel des freins T1', 'Chaque 30 jours', 'Contrôle', 'EQ-TRK01-FRN'),
('IP-2026-002', 'Vidange moteur standard & filtres', 'Chaque 10 000 KM', 'Contrôle', 'EQ-TRK03-MOT'),
('IP-2026-003', 'Inspection annuelle boîte auto', 'Chaque 365 jours', 'Amélioration', 'EQ-TRK02-TRN'),
('IP-2026-004', 'Permutation pneus train arrière', 'Chaque 20 000 KM', 'Contrôle', 'EQ-TRK02-PNE'),
('IP-2026-005', 'Entretien préventif Scania V8', 'Chaque 90 jours', 'Contrôle', 'EQ-TRK05-MOT'),
('IP-2026-006', 'Vérification géométrie parallélisme', 'Chaque 180 jours', 'Contrôle', 'EQ-TRK04-CHX'),
('IP-2026-007', 'Nettoyage bornes alternateur', 'Chaque 30 jours', 'Contrôle', 'EQ-TRK03-ELC'),
('IP-2026-008', 'Vidange moteur Cummins 15L', 'Chaque 10 000 KM', 'Contrôle', 'EQ-TRK01-MOT'),
('IP-2026-009', 'Renouvellement huile hydraulique', 'Chaque 12 mois', 'Contrôle', 'EQ-TRK02-HYD'),
('IP-2026-010', 'Contrôle usure amortisseurs AV', 'Chaque 6 mois', 'Contrôle', 'EQ-TRK01-SUS'),
('IP-2026-011', 'Graissage complet des pivots', 'Chaque 5 000 KM', 'Contrôle', 'EQ-TRK04-CHX'),
('IP-2026-012', 'Test d''étanchéité circuit air', 'Chaque 60 jours', 'Contrôle', 'EQ-TRK01-FRN'),
('IP-2026-013', 'Remplacement préventif courroie', 'Chaque 50 000 KM', 'Remplacement', 'EQ-TRK01-MOT'),
('IP-2026-014', 'Analyse d''huile de transmission', 'Chaque 6 mois', 'Contrôle', 'EQ-TRK02-TRN'),
('IP-2026-015', 'Tarage des injecteurs Volvo', 'Chaque 100 000 KM', 'Ajustement', 'EQ-TRK03-MOT'),
('IP-2026-016', 'Pression et usure flotte pneus', 'Chaque semaine', 'Contrôle', 'EQ-TRK02-PNE'),
('IP-2026-017', 'Contrôle serrage écrous roues', 'Chaque 15 jours', 'Contrôle', 'EQ-TRK04-CHX'),
('IP-2026-018', 'Nettoyage radiateur de refroidissement', 'Chaque été', 'Entretien', 'EQ-TRK01-MOT'),
('IP-2026-019', 'Remplacement filtre déshydrateur', 'Chaque 12 mois', 'Remplacement', 'EQ-TRK01-FRN'),
('IP-2026-020', 'Inspection faisceau électrique', 'Chaque 180 jours', 'Contrôle', 'EQ-TRK03-ELC'),
('IP-2026-021', 'Remplacement préventif joints pompe', 'Chaque 24 mois', 'Remplacement', 'EQ-TRK02-HYD'),
('IP-2026-022', 'Contrôle des suspensions cabine', 'Chaque 6 mois', 'Contrôle', 'EQ-TRK01-SUS'),
('IP-2026-023', 'Vidange pont arrière camion 2', 'Chaque 40 000 KM', 'Entretien', 'EQ-TRK02-TRN'),
('IP-2026-024', 'Remplacement cartouche dessiccateur', 'Chaque 30 000 KM', 'Remplacement', 'EQ-TRK01-FRN'),
('IP-2026-025', 'Remplacement filtres habitacle', 'Chaque 15 000 KM', 'Entretien', 'EQ-TRK03-ELC'),
('IP-2026-026', 'Contrôle jeu sellette attelage', 'Chaque 3 mois', 'Contrôle', 'EQ-TRK04-CHX'),
('IP-2026-027', 'Nettoyage crépine réservoir', 'Chaque 50 000 KM', 'Entretien', 'EQ-TRK01-MOT'),
('IP-2026-028', 'Remplacement préventif ampoules AV', 'Chaque hiver', 'Remplacement', 'EQ-TRK03-ELC'),
('IP-2026-029', 'Remplacement liquide de frein', 'Chaque 2 ans', 'Remplacement', 'EQ-TRK01-FRN'),
('IP-2026-030', 'Inspection d''étanchéité boîte de vitesses', 'Chaque 90 jours', 'Contrôle', 'EQ-TRK02-TRN'),
('IP-2026-031', 'Remplacement préventif flexibles hydrauliques', 'Chaque 3 ans', 'Remplacement', 'EQ-TRK02-HYD'),
('IP-2026-032', 'Mesure épaisseur disques de frein', 'Chaque 45 jours', 'Contrôle', 'EQ-TRK01-FRN'),
('IP-2026-033', 'Contrôle fixations moteur', 'Chaque 180 jours', 'Contrôle', 'EQ-TRK05-MOT'),
('IP-2026-034', 'Nettoyage capteurs ABS', 'Chaque 60 jours', 'Entretien', 'EQ-TRK01-FRN'),
('IP-2026-035', 'Contrôle soufflets d''amortisseurs', 'Chaque 6 mois', 'Contrôle', 'EQ-TRK01-SUS'),
('IP-2026-036', 'Remplacement filtre à eau', 'Chaque 30 000 KM', 'Remplacement', 'EQ-TRK01-MOT'),
('IP-2026-037', 'Vérification niveau d''électrolyte', 'Chaque 30 000 KM', 'Contrôle', 'EQ-TRK03-ELC'),
('IP-2026-038', 'Vérification béquilles de remorque', 'Chaque 6 mois', 'Contrôle', 'EQ-TRK04-CHX'),
('IP-2026-039', 'Remplacement préventif courroie alternateur', 'Chaque 60 000 KM', 'Remplacement', 'EQ-TRK03-ELC'),
('IP-2026-040', 'Vidange boîte transfert', 'Chaque 50 000 KM', 'Entretien', 'EQ-TRK02-TRN'),
('IP-2026-041', 'Lavage châssis anti-sel', 'Chaque fin d''hiver', 'Nettoyage', 'EQ-TRK04-CHX'),
('IP-2026-042', 'Remplacement filtre reniflard', 'Chaque 40 000 KM', 'Remplacement', 'EQ-TRK01-MOT'),
('IP-2026-043', 'Vérification accumulateurs de pression', 'Chaque 12 mois', 'Contrôle', 'EQ-TRK02-HYD'),
('IP-2026-044', 'Contrôle fixations échappement', 'Chaque 90 jours', 'Contrôle', 'EQ-TRK04-CHX'),
('IP-2026-045', 'Remplacement capteur pression pneu', 'Chaque 2 ans', 'Remplacement', 'EQ-TRK02-PNE'),
('IP-2026-046', 'Contrôle usure garnitures tambours', 'Chaque 6 mois', 'Contrôle', 'EQ-TRK01-FRN'),
('IP-2026-047', 'Remplacement liquide refroidissement', 'Chaque 100 000 KM', 'Remplacement', 'EQ-TRK03-MOT'),
('IP-2026-048', 'Contrôle suspension pneumatique cabine', 'Chaque 180 jours', 'Contrôle', 'EQ-TRK01-SUS'),
('IP-2026-049', 'Nettoyage injecteur AdBlue', 'Chaque 40 000 KM', 'Entretien', 'EQ-TRK05-MOT'),
('IP-2026-050', 'Inspection structurelle pivot central', 'Chaque 2 ans', 'Contrôle', 'EQ-TRK04-CHX');

-- ==========================================
-- 4. FACT_BT: 50 ROWS (BONS DE TRAVAIL)
-- ==========================================
INSERT INTO Fact_BT (numero_bt, numero_di, numero_ip, date_debut_prevue, date_debut_reel, date_fin_prevue, date_fin_reelle, etat_bt, type_work, designation_travaux, degre_urgence, code_equipement) VALUES 
('BT-2026-001', 'DI-2026-001', NULL, '2026-07-01 08:00:00', '2026-07-01 08:30:00', '2026-07-01 12:00:00', '2026-07-01 11:15:00', 'Fait', 'Correctif', 'Changement filtre carburant.', 'Élevé', 'EQ-TRK01-MOT'),
('BT-2026-002', NULL, 'IP-2026-001', '2026-07-02 09:00:00', '2026-07-02 09:15:00', '2026-07-02 11:00:00', NULL, 'En cours', 'Préventif', 'Mesure usure plaquettes.', 'Moyen', 'EQ-TRK01-FRN'),
('BT-2026-003', NULL, 'IP-2026-002', '2026-07-02 07:00:00', '2026-07-02 07:05:00', '2026-07-02 10:00:00', '2026-07-02 09:45:00', 'Fait', 'Préventif', 'Changement filtre air admission.', 'Moyen', 'EQ-TRK03-MOT'),
('BT-2026-004', 'DI-2026-003', NULL, '2026-07-03 13:00:00', NULL, '2026-07-03 16:00:00', NULL, 'À faire', 'Correctif', 'Changement joints pompe.', 'Élevé', 'EQ-TRK02-HYD'),
('BT-2026-005', 'DI-2026-004', NULL, '2026-07-03 10:00:00', NULL, '2026-07-03 11:00:00', NULL, 'À faire', 'Correctif', 'Test fusibles.', 'Faible', 'EQ-TRK03-ELC'),
('BT-2026-006', 'DI-2026-002', NULL, '2026-07-04 08:00:00', '2026-07-04 08:10:00', '2026-07-04 10:00:00', '2026-07-04 09:30:00', 'Fait', 'Correctif', 'Changement plaquettes frein.', 'Moyen', 'EQ-TRK01-FRN'),
('BT-2026-007', 'DI-2026-009', NULL, '2026-07-04 14:00:00', '2026-07-04 14:05:00', '2026-07-04 15:00:00', '2026-07-04 14:45:00', 'Fait', 'Correctif', 'Montage pneu neuf.', 'Élevé', 'EQ-TRK02-PNE'),
('BT-2026-008', 'DI-2026-010', NULL, '2026-07-05 09:00:00', '2026-07-05 09:00:00', '2026-07-05 09:30:00', '2026-07-05 09:15:00', 'Fait', 'Correctif', 'Ampoule neuve.', 'Faible', 'EQ-TRK03-ELC'),
('BT-2026-009', 'DI-2026-006', NULL, '2026-07-05 11:00:00', '2026-07-05 11:15:00', '2026-07-05 15:00:00', NULL, 'En cours', 'Correctif', 'Détartrage radiateur.', 'Critique', 'EQ-TRK01-MOT'),
('BT-2026-010', NULL, 'IP-2026-004', '2026-07-06 08:00:00', '2026-07-06 08:00:00', '2026-07-06 12:00:00', '2026-07-06 11:30:00', 'Fait', 'Préventif', 'Permutation pneus.', 'Moyen', 'EQ-TRK02-PNE'),
('BT-2026-011', NULL, 'IP-2026-008', '2026-07-06 13:00:00', NULL, '2026-07-06 16:00:00', NULL, 'À faire', 'Préventif', 'Vidange bloc Cummins.', 'Moyen', 'EQ-TRK01-MOT'),
('BT-2026-012', 'DI-2026-012', NULL, '2026-07-07 08:00:00', '2026-07-07 08:20:00', '2026-07-07 12:00:00', NULL, 'En cours', 'Correctif', 'Recherche fuite huile.', 'Élevé', 'EQ-TRK05-MOT'),
('BT-2026-013', 'DI-2026-014', NULL, '2026-07-07 10:00:00', '2026-07-07 10:10:00', '2026-07-07 13:00:00', NULL, 'En cours', 'Correctif', 'Purge circuit frein.', 'Critique', 'EQ-TRK01-FRN'),
('BT-2026-014', NULL, 'IP-2026-010', '2026-07-07 14:00:00', NULL, '2026-07-07 16:00:00', NULL, 'À faire', 'Préventif', 'Test compression amortisseurs.', 'Moyen', 'EQ-TRK01-SUS'),
('BT-2026-015', NULL, 'IP-2026-007', '2026-07-08 08:00:00', NULL, '2026-07-08 09:30:00', NULL, 'À faire', 'Préventif', 'Nettoyage cosses batterie.', 'Faible', 'EQ-TRK03-ELC'),
-- Adding remaining simulated rows to reach 50 unique BT entries
('BT-2026-016', 'DI-2026-016', NULL, '2026-07-08 10:00:00', NULL, '2026-07-08 14:00:00', NULL, 'À faire', 'Correctif', 'Analyse fumée échappement', 'Élevé', 'EQ-TRK01-MOT'),
('BT-2026-017', NULL, 'IP-2026-013', '2026-07-08 13:00:00', '2026-07-08 13:05:00', '2026-07-08 15:00:00', '2026-07-08 14:50:00', 'Fait', 'Préventif', 'Changement courroie accessoires', 'Moyen', 'EQ-TRK01-MOT'),
('BT-2026-018', 'DI-2026-022', NULL, '2026-07-09 08:00:00', '2026-07-09 08:00:00', '2026-07-09 09:00:00', '2026-07-09 08:45:00', 'Fait', 'Correctif', 'Moteur essuie-glace changé', 'Faible', 'EQ-TRK03-ELC'),
('BT-2026-019', 'DI-2026-029', NULL, '2026-07-09 10:00:00', '2026-07-09 10:15:00', '2026-07-09 12:00:00', '2026-07-09 11:40:00', 'Fait', 'Correctif', 'Durite neuve insérée', 'Élevé', 'EQ-TRK03-MOT'),
('BT-2026-020', NULL, 'IP-2026-017', '2026-07-09 14:00:00', '2026-07-09 14:00:00', '2026-07-09 15:00:00', '2026-07-09 14:30:00', 'Fait', 'Préventif', 'Clé dynamométrique écrous', 'Moyen', 'EQ-TRK04-CHX'),
('BT-2026-021', 'DI-2026-030', NULL, '2026-07-10 09:00:00', '2026-07-10 09:05:00', '2026-07-10 09:30:00', '2026-07-10 09:20:00', 'Fait', 'Correctif', 'Bloc optique ampoule changé', 'Faible', 'EQ-TRK03-ELC'),
('BT-2026-022', 'DI-2026-035', NULL, '2026-07-10 11:00:00', '2026-07-10 11:00:00', '2026-07-10 12:00:00', '2026-07-10 11:45:00', 'Fait', 'Correctif', 'Graissage plateau sellette', 'Faible', 'EQ-TRK04-CHX'),
('BT-2026-023', 'DI-2026-043', NULL, '2026-07-10 13:00:00', '2026-07-10 13:10:00', '2026-07-10 14:00:00', '2026-07-10 13:45:00', 'Fait', 'Correctif', 'Serrage raccord bloc hydro', 'Faible', 'EQ-TRK02-HYD'),
('BT-2026-024', 'DI-2026-044', NULL, '2026-07-11 08:00:00', '2026-07-11 08:00:00', '2026-07-11 08:30:00', '2026-07-11 08:20:00', 'Fait', 'Correctif', 'Bouchon réservoir lave-glace', 'Faible', 'EQ-TRK03-ELC'),
('BT-2026-025', 'DI-2026-049', NULL, '2026-07-11 09:00:00', '2026-07-11 09:30:00', '2026-07-11 11:00:00', '2026-07-11 10:45:00', 'Fait', 'Correctif', 'Dépannage pneu éclaté sur site', 'Élevé', 'EQ-TRK02-PNE'),
('BT-2026-026', NULL, 'IP-2026-019', '2026-07-12 08:00:00', NULL, '2026-07-12 10:00:00', NULL, 'À faire', 'Préventif', 'Filtre déshydrateur air neuf', 'Moyen', 'EQ-TRK01-FRN'),
('BT-2026-027', NULL, 'IP-2026-028', '2026-07-12 10:00:00', NULL, '2026-07-12 11:30:00', NULL, 'À faire', 'Préventif', 'Remplacement kit ampoules hiver', 'Faible', 'EQ-TRK03-ELC'),
('BT-2026-028', NULL, 'IP-2026-036', '2026-07-12 13:00:00', NULL, '2026-07-12 14:00:00', NULL, 'À faire', 'Préventif', 'Filtre à eau système de refroid.', 'Moyen', 'EQ-TRK01-MOT'),
('BT-2026-029', 'DI-2026-023', NULL, '2026-07-13 08:00:00', NULL, '2026-07-13 12:00:00', NULL, 'À faire', 'Correctif', 'Démontage conduit alimentation turbo', 'Élevé', 'EQ-TRK03-MOT'),
('BT-2026-030', 'DI-2026-013', NULL, '2026-07-13 13:00:00', NULL, '2026-07-13 17:00:00', NULL, 'À faire', 'Correctif', 'Remplacement du bras de suspension', 'Élevé', 'EQ-TRK04-CHX'),
('BT-2026-031', NULL, 'IP-2026-003', '2026-07-14 08:00:00', NULL, '2026-07-14 16:00:00', NULL, 'À faire', 'Préventif', 'Inspection fin d''année transmission', 'Moyen', 'EQ-TRK02-TRN'),
('BT-2026-032', NULL, 'IP-2026-005', '2026-07-15 08:00:00', NULL, '2026-07-15 12:00:00', NULL, 'À faire', 'Préventif', 'Entretien filtre à huile Scania', 'Moyen', 'EQ-TRK05-MOT'),
('BT-2026-033', NULL, 'IP-2026-006', '2026-07-15 13:00:00', NULL, '2026-07-15 17:00:00', NULL, 'À faire', 'Préventif', 'Passage au banc de parallélisme', 'Moyen', 'EQ-TRK04-CHX'),
('BT-2026-034', NULL, 'IP-2026-009', '2026-07-16 08:00:00', NULL, '2026-07-16 16:00:00', NULL, 'À faire', 'Préventif', 'Vidange complète fluide hydro', 'Moyen', 'EQ-TRK02-HYD'),
('BT-2026-035', NULL, 'IP-2026-011', '2026-07-17 08:00:00', NULL, '2026-07-17 10:00:00', NULL, 'À faire', 'Préventif', 'Graissage des pivots fusées', 'Faible', 'EQ-TRK04-CHX'),
('BT-2026-036', NULL, 'IP-2026-012', '2026-07-17 10:30:00', NULL, '2026-07-17 12:00:00', NULL, 'À faire', 'Préventif', 'Recherche fuites micro-pores air', 'Moyen', 'EQ-TRK01-FRN'),
('BT-2026-037', NULL, 'IP-2026-014', '2026-07-17 13:00:00', NULL, '2026-07-17 15:00:00', NULL, 'À faire', 'Préventif', 'Prélèvement échantillon huile boîte', 'Moyen', 'EQ-TRK02-TRN'),
('BT-2026-038', NULL, 'IP-2026-015', '2026-07-18 08:00:00', NULL, '2026-07-18 17:00:00', NULL, 'À faire', 'Préventif', 'Démontage injecteurs banc étalonnage', 'Moyen', 'EQ-TRK03-MOT'),
('BT-2026-039', NULL, 'IP-2026-016', '2026-07-19 08:00:00', NULL, '2026-07-19 09:30:00', NULL, 'À faire', 'Préventif', 'Mesure profondeur sculptures pneus', 'Faible', 'EQ-TRK02-PNE'),
('BT-2026-040', NULL, 'IP-2026-018', '2026-07-19 10:00:00', NULL, '2026-07-19 14:00:00', NULL, 'À faire', 'Préventif', 'Nettoyage haute pression ailettes rad.', 'Moyen', 'EQ-TRK01-MOT'),
('BT-2026-041', NULL, 'IP-2026-020', '2026-07-20 08:00:00', NULL, '2026-07-20 12:00:00', NULL, 'À faire', 'Préventif', 'Vérification gaines et passages câbles', 'Moyen', 'EQ-TRK03-ELC'),
('BT-2026-042', NULL, 'IP-2026-021', '2026-07-20 13:00:00', NULL, '2026-07-20 17:00:00', NULL, 'À faire', 'Préventif', 'Remplacement kit étanchéité préventif', 'Moyen', 'EQ-TRK02-HYD'),
('BT-2026-043', NULL, 'IP-2026-022', '2026-07-21 08:00:00', NULL, '2026-07-21 11:00:00', NULL, 'À faire', 'Préventif', 'Contrôle boudins pneumatiques cabine', 'Moyen', 'EQ-TRK01-SUS'),
('BT-2026-044', NULL, 'IP-2026-023', '2026-07-21 13:00:00', NULL, '2026-07-21 16:00:00', NULL, 'À faire', 'Préventif', 'Vidange carter pont train arrière', 'Moyen', 'EQ-TRK02-TRN'),
('BT-2026-045', NULL, 'IP-2026-024', '2026-07-22 08:00:00', NULL, '2026-07-22 10:00:00', NULL, 'À faire', 'Préventif', 'Changement cartouche dessiccateur', 'Moyen', 'EQ-TRK01-FRN'),
('BT-2026-046', NULL, 'IP-2026-025', '2026-07-22 10:30:00', NULL, '2026-07-22 11:30:00', NULL, 'À faire', 'Préventif', 'Changement élément filtrant pollen', 'Faible', 'EQ-TRK03-ELC'),
('BT-2026-047', NULL, 'IP-2026-026', '2026-07-22 13:00:00', NULL, '2026-07-22 14:30:00', NULL, 'À faire', 'Préventif', 'Mesure jeu mâchoires verrouillage', 'Moyen', 'EQ-TRK04-CHX'),
('BT-2026-048', NULL, 'IP-2026-027', '2026-07-23 08:00:00', NULL, '2026-07-23 12:00:00', NULL, 'À faire', 'Préventif', 'Aspiration sédiments fond de cuve', 'Moyen', 'EQ-TRK01-MOT'),
('BT-2026-049', NULL, 'IP-2026-029', '2026-07-23 13:00:00', NULL, '2026-07-23 15:00:00', NULL, 'À faire', 'Préventif', 'Remplacement fluide DOT4 complet', 'Moyen', 'EQ-TRK01-FRN'),
('BT-2026-050', NULL, 'IP-2026-030', '2026-07-24 08:00:00', NULL, '2026-07-24 10:00:00', NULL, 'À faire', 'Préventif', 'Suivi suintements joints spi boîte', 'Faible', 'EQ-TRK02-TRN');

-- ==========================================
-- 5. FACT_CONSOMMATION: LOGISTICS USAGE
-- ==========================================
INSERT INTO Fact_Consommation (numero_bt, code_piece, quantite_consommee) VALUES 
('BT-2026-001', 'P-FLT-88', 2),
('BT-2026-001', 'P-OIL-05', 15),
('BT-2026-003', 'P-FLT-90', 1),
('BT-2026-003', 'P-OIL-05', 12),
('BT-2026-006', 'P-BRK-12', 4),
('BT-2026-007', 'P-PNE-45', 1),
('BT-2026-008', 'P-ELC-09', 2),
('BT-2026-010', 'P-PNE-45', 2),
('BT-2026-002', 'P-BRK-12', 2),
('BT-2026-013', 'P-OIL-05', 3),
('BT-2026-017', 'P-ELC-09', 1),
('BT-2026-019', 'P-OIL-05', 4),
('BT-2026-025', 'P-PNE-45', 1); 


USE gmao_camions;

USE gmao_camions;

-- Add the automatic database-calculated columns directly
ALTER TABLE Fact_BT 
ADD COLUMN Duree_Reparation_Heures INT GENERATED ALWAYS AS (TIMESTAMPDIFF(HOUR, date_debut_reel, date_fin_reelle)) VIRTUAL,
ADD COLUMN Temps_Reponse_Heures INT GENERATED ALWAYS AS (TIMESTAMPDIFF(HOUR, date_debut_prevue, date_debut_reel)) VIRTUAL;