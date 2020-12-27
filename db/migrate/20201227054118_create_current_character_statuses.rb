class CreateCurrentCharacterStatuses < ActiveRecord::Migration[5.0]
  def self.up
    execute("DROP VIEW IF EXISTS current_character_status;")
    create_view :current_character_statuses
  end

  def self.down
    drop_view :current_character_statuses
    execute <<-SQL
      CREATE VIEW IF NOT EXISTS current_character_status AS
      SELECT
        c.id AS id,
        c.id AS character_id,
        c.name AS name,
        COALESCE(c.starting_points, 0) + COALESCE(d.points, 0) + COALESCE(mps.points, 0) + COALESCE(cpa.points, 0) AS points,
        COALESCE(c.starting_death_thresholds, 0) + COALESCE(dta.death_thresholds, 0) - COALESCE(d.deaths, 0) AS death_thresholds,
        COALESCE( (SELECT id FROM guild_memberships gm WHERE gm.character_id = c.id AND approved = 't' ORDER BY declared_on DESC, id DESC LIMIT 1), (SELECT id FROM guild_memberships gm WHERE gm.character_id = c.id ORDER BY declared_on DESC, id DESC LIMIT 1)) AS guild_membership
        FROM
          characters c
          LEFT JOIN
          (SELECT 
            c.id AS id, 
            cast((total(COALESCE(d.base_points, g.player_points_base) + COALESCE(d.points_modifier, 0))) AS INTEGER) AS points,
            cast((total(COALESCE(d.deaths, 0))) AS INTEGER) AS deaths
            FROM
              characters c
              INNER JOIN debriefs d ON d.character_id = c.id
              INNER JOIN games g ON d.game_id = g.id
            WHERE
              g.debrief_started = 't'
              AND
              g.open = 'f'
              AND
              g.start_date >= c.declared_on
            GROUP BY c.id) d ON c.id = d.id
          LEFT JOIN
          (SELECT
            c.id AS id,
            cast((total(mps.character_points_gained)) AS INTEGER) AS points
            FROM
              characters c
              INNER JOIN monster_point_spends mps ON mps.character_id = c.id
            WHERE
              mps.spent_on >= c.declared_on
            GROUP BY c.id) mps ON c.id = mps.id
          LEFT JOIN
          (SELECT
            c.id AS id,
            cast((total(cpa.points)) AS INTEGER) AS points
            FROM
              characters c
              INNER JOIN character_point_adjustments cpa ON cpa.character_id = c.id
            WHERE
              cpa.declared_on >= c.declared_on
              AND
              cpa.approved = 't'
            GROUP BY c.id) cpa ON c.id = cpa.id
          LEFT JOIN
          (SELECT
            c.id AS id,
            cast((total(dta.change)) AS INTEGER) AS death_thresholds
            FROM
              characters c
              INNER JOIN death_threshold_adjustments dta ON dta.character_id = c.id
            WHERE
              dta.declared_on >= c.declared_on
              AND
              dta.approved = 't'
            GROUP BY c.id) dta ON c.id = dta.id
    SQL
  end
end
